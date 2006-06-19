Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 14:54:50 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:53576 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133524AbWFSNyk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Jun 2006 14:54:40 +0100
Received: by ug-out-1314.google.com with SMTP id k3so2708677ugf
        for <linux-mips@linux-mips.org>; Mon, 19 Jun 2006 06:54:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kPBasNYaZ9vFcihdr17a2vxqdV07zNhCjoT9Hx9naQAFS4BPNC8pe2KkFmDY4C1h2xI6qEOw3BoABJkYYdnQhs6eSgT9aoVODZj5X6TwVjhFzAjpfIYZAWBRDu3sm0LoHIX5UWYH8Ts5lVXcdU41RiDXEATmerMDnZ//4i7B3O4=
Received: by 10.78.44.11 with SMTP id r11mr2001170hur;
        Mon, 19 Jun 2006 06:54:39 -0700 (PDT)
Received: by 10.78.128.10 with HTTP; Mon, 19 Jun 2006 06:54:39 -0700 (PDT)
Message-ID: <f69849430606190654m6688a8bbt17ee67f009f56634@mail.gmail.com>
Date:	Mon, 19 Jun 2006 18:54:39 +0500
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: gcc port based on MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
  I'm trying to port gcc for a processor which is very similar to
MIPS.Today i just tried to compile gcc-4.1.0 for this processor by
changing configuration files.
First i changed the config.sub file in base directory and just added
the name of processor ABC.
Then i changed the configure.ac file in gcc/ subdirectory and added
following lines.

  ABC*)
    conftest_s='
        .section .tdata,"awT",@progbits
x:
        .word 2
        .text
        addiu $4, $28, %tlsgd(x)
        addiu $4, $28, %tlsldm(x)
        lui $4, %dtprel_hi(x)
        addiu $4, $4, %dtprel_lo(x)
        lw $4, %gottprel(x)($28)
        lui $4, %tprel_hi(x)
        addiu $4, $4, %tprel_lo(x)'
        tls_first_major=2
        tls_first_minor=16
        tls_as_opt='-32 --fatal-warnings'
        ;;
As you can see it was just copy paste of  mips*-*-*) option.

Then i did following changes to config.gcc file in gcc/ subdirectory

ABC*)
        cpu_type=ABC
        ;;
 - - - - - - - - - - -
 - - - -- - - - - - --
ABC*)
        tm_file="dbxelf.h elfos.h svr4.h linux.h ${tm_file} ABC/linux.h"
        ;;


Then i made  a directory  gcc-4.1.0/gcc/config/ABC/.I copied all files
of gcc-4.1.0/gcc/config/mips to ABC directory and renamed following
files.

mips.h                  --------------   ABC.h
mips.md               --------------    ABC.md
mips.c                  --------------    ABC.c
mips-modes.def     -------------    ABC-modes.def
mips-protos.h        -------------     ABC-protos.h
mips.opt               -------------     ABC.opt

But when i issued the make all-gcc command .Following error occured

../../gcc-4.1.0/gcc/config/ABC/ABC.md: unknown mode `V2SF'

Would u please explain why this error is being generated.Also a bit of
explaination of 'V2SF' mode will helpful.

Then i removed the 'V2SF' mode from patterns in ABC.md file.But now
following error was generated.

../../gcc-4.1.0/gcc/config/ABC/ABC.md:228: unknown value
`<ANYF:UNITMODE>' for `mode' attribute
../../gcc-4.1.0/gcc/config/ABC/ABC.md:228: unknown value
`<ANYF:UNITMODE>' for `mode' attribute
../../gcc-4.1.0/gcc/config/ABC/ABC.md:228: unknown value `<UNITMODE>'
for `mode' attribute
../../gcc-4.1.0/gcc/config/ABC/ABC.md:228: unknown value `<UNITMODE>'
for `mode' attribute


Would you please tell me why this error is being generated.

thanks,
shahzad
