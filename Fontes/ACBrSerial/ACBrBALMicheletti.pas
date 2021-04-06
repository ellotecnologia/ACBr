{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  André Angeluci                                 }
{                               Juliomar Marchetti                             }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrBALMicheletti;

interface

uses
  Classes,
  ACBrBALClass
  {$IFDEF NEXTGEN}
   ,ACBrBase
  {$ENDIF};
  
type
  TACBrBALMicheletti = class(TACBrBALClass)
  public
    constructor Create(AOwner: TComponent);
    function InterpretarRepostaPeso(const aResposta: AnsiString): Double; override;
end;

implementation

uses
  SysUtils, ACBrConsts;

{ TACBrBALMicheletti }

constructor TACBrBALMicheletti.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fpModeloStr := 'Micheletti';
end;

function TACBrBALMicheletti.InterpretarRepostaPeso(const aResposta: AnsiString): Double;
var
  wPos: integer;
  wQtd: integer;
  wResposta: AnsiString;
begin
  Result := 0;

  if (aResposta = EmptyStr) then
    Exit;

  wPos  := Pos('<SB>3:', aResposta) - 1;
  wResposta := Copy(aResposta, wPos + 7, 10);
  wQtd      := (Pos('kg', wResposta));
  wResposta := Copy(wResposta, 1, wQtd-1);
  wResposta := StringReplace(wResposta, '.', DecimalSeparator, [rfReplaceAll]);
  wResposta := StringReplace(wResposta, ',', DecimalSeparator, [rfReplaceAll]);

  Result    := StrToFloatDef(wResposta, 0);
end;

end.
