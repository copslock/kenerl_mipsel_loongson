Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 04:19:39 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:42166 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021352AbZEODTe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 04:19:34 +0100
Received: by pzk40 with SMTP id 40so923912pzk.22
        for <multiple recipients>; Thu, 14 May 2009 20:19:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer;
        bh=9kzVkXrIg6eSieN115RxuY+JtzAQhqRkQgVpXAdOiOs=;
        b=SgpL/ULH6CIDt4ODiTkm/698IFAseCagXyc2/5p0Q4OO2JRweWwalBjO5jkrCxXn8i
         wd/TjL/8XkSsvblD4Kgz+CnVnri7oMkJPUQmDkqHqwAPlnXwwATP8e/Xle5XN1cyn37t
         5s1Z8YOgYv4b6jqDsLPPomlFo8xj9LobIrqCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer;
        b=i+U1jsDgrMM1zB8/UwVFaDyuwkeC4YqYy+mOZiqXlmIyMdznFHkkHStD5t18KoLYku
         FStzUh3pmIf3g7B1qPFURjxK9qYowdbk2/wdrFsu5JWQj7aQVqgQEFCUQQKlGKttxw2C
         0Bbi1BQSjJxk7EMxNKu+7IFvuuwW0xcp67IQA=
Received: by 10.142.221.11 with SMTP id t11mr993348wfg.23.1242357566205;
        Thu, 14 May 2009 20:19:26 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 31sm1546392wff.4.2009.05.14.20.19.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 20:19:25 -0700 (PDT)
Subject: [GIT repo] loongson: Merge and Clean up fuloong(2e), fuloong(2f)
 and yeeloong(2f) support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>, Zhang Le <r0bertz@gentoo.org>
Content-Type: multipart/mixed; boundary="=-DZky3f3xv7HfSXhPJroI"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 15 May 2009 11:19:13 +0800
Message-Id: <1242357553.30339.66.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips


--=-DZky3f3xv7HfSXhPJroI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dear all,

I have cleaned up the source code of loongson-based machines support and
updated it to linux-2.6.29.3, the result is put to the following git
repository:

   git://dev.lemote.com/rt4ls.git linux-2.6.29-stable-loongson-to-ralf

this job is based on the to-mips branch of Yanhua's
git://dev.lemote.com/linux_loongson.git and the lm2e-fixes branch of
Philippe's git://git.linux-cisco.org/linux-mips.git. thanks goes to
them.

I have tested it with gcc 4.3 on fuloong(2e), fuloong(2f), yeeloong(2f),
both 32bit and 64bit kernel works well, if you want to try it with gcc
4.4, please use the patch from attachment.

* the current source code architecture

$ tree arch/mips/loongson/
arch/mips/loongson/
|-- Kconfig
|-- Makefile
|-- common
|   |-- Makefile
|   |-- bonito-irq.c
|   |-- clock.c
|   |-- cmdline.c
|   |-- cs5536_vsm.c
|   |-- early_printk.c
|   |-- init.c
|   |-- irq.c
|   |-- mem.c
|   |-- mfgpt.c
|   |-- mipsdha.c
|   |-- misc.c
|   |-- pci.c
|   |-- reset.c
|   |-- rtc.c
|   |-- serial.c
|   |-- setup.c
|   `-- time.c
|-- fuloong-2e
|   |-- Makefile
|   |-- irq.c
|   `-- reset.c
|-- fuloong-2f
|   |-- Makefile
|   |-- irq.c
|   `-- reset.c
`-- yeeloong-2f
    |-- Makefile
    |-- init.c
    |-- irq.c
    `-- reset.c
4 directories, 30 files

$ tree arch/mips/include/asm/mach-loongson/
arch/mips/include/asm/mach-loongson/
|-- cpu-feature-overrides.h
|-- cs5536
|   |-- cs5536.h
|   |-- cs5536_pci.h
|   |-- mfgpt.h
|   `-- pcireg.h
|-- dma-coherence.h
|-- fuloong-2e
|   `-- machine.h
|-- fuloong-2f
|   `-- machine.h
|-- loongson.h
|-- mc146818rtc.h
|-- war.h
`-- yeeloong-2f
    `-- machine.h
4 directories, 12 files

$ ls arch/mips/pci/fixup-lemote2*
arch/mips/pci/fixup-lemote2e.c  arch/mips/pci/fixup-lemote2f.c
$ ls arch/mips/pci/ops-loongson2.c 
arch/mips/pci/ops-loongson2.c

* the main changes

1. make the source code of loongson support scalable, sharable

  a. rename some lemote* names to loongson* names to support non-lemote
machines 
  b. remove the reference to bonito64, add a new loongson.h header file
  c. split the source code to loongson-specific(common/) &
board-specific parts(board-name/)
  d. divide the source code files to the smallest logic function unit   
  e. replace tons of magic numbers to understandable macros
  d. initialize several base addresses to simplify MMIO operation
  f. fixup RTC support

2. add basic lemote fuloong(2f) mini notebook support

  a. add AMD cs5536 south bridge support
  b. add fuloong-specific reboot/halt operation
  c. add fuloong-specific irq operation
  d. add cs5536 mfgpt timer support
  e. add cpu frequency scaling support
  f. add MIPS STD support

3. add basic lemote yeeloong(2f) mini notebook support

  a. add yeeloong-specific reboot/halt operation
  b. add yeeloong-specific command line operation

you can get the detail change logs from the git log.

Welcome your comments and suggestions. highly hope some fuloong and
yeeloong users help to test it, thanks!

best regards!
Wu Zhangjin

--=-DZky3f3xv7HfSXhPJroI
Content-Disposition: attachment; filename="linux-loongson-gcc4.4.patch.tar.gz"
Content-Type: application/x-compressed-tar; name="linux-loongson-gcc4.4.patch.tar.gz"
Content-Transfer-Encoding: base64

H4sIAAU6DEoAA+2VbW/aMBDHeQuf4obaKlkw5Im03UTVim0IaS0VbVdeIEXBccCrSVDiTO2mffc5
gdKCAmVTpWmafy9wbN//fL7LEUbD9B6xKArHSRSiMcZ23a7PPI4npddCFzi2nY3GYVN/PmZYhumU
DMPULd2yD3WnpBtNy3JKoL9aBFtIE+7FAKXAYzgKN9u9tP+P4tMgAITGlIPX8GI8aUzpLGmce3ck
oIzAqGCxQkOf3IM9wh62nHq9aRybnuOAkZe5ghAq9FXRNK3Y3+kpIMM4rh2CNh/EAg6YN07QntLu
XXzqdtz25Y3bty1dV8taC9A0c9OKswVAt14NIR57s0qh7EvfNgaDVZ2xg65vD9aPc3aQXQ/s4/Xj
1nSoSPe517voXPUuzK1SbWfpY1ObwVw/Dajo9MQM0B2JQ8K2XuK8e3llmW7fyD3uKdhjDDBG0YzT
KKwtjsjKaJlilo+A5jq3e3UG6MPyubV8WrhVYViBcrk8D2uhfSGrjwGZOwQUL0OKfy+oDd1AQ8xS
nzS8ZNrwCfMe6pOVF7lgf9EjI32EsW/W6/5Ib9oEb+qRIg/r7VJkk3XOkVkzTNCyQc86R/yhcYqB
hoyGBL5F1AfXTXOFkoYJHYfEBybeDUgTgpMarC6y2Vc1q847qLYmVVByI7UmZkzMWPS4GT/fyyZP
wk677fY/dtyzdvvmXH1fQWXCEgI0ACWh30kUKNlJKrRacAQHB/Cmb4vvgHt71leFbdl1xRVdV6n6
05TxdMj3zRrsW9Vsb3NUaEtU6E+iehaUtvsF4IewLvOHGfFJ8JRaGnJIxY9hHrlc1MPjPKajlBNx
T2Ua+US57qqqiEqI8/ihBYqyVKjzWsHbvDxwcgKOndn+hJ3vAEWJtURi7WE45NNgQsVcrz6WfiWR
econdOe34G9/1SQSiUQikUgkEolEIpFIJBKJRCKRSCQSiUQi+b/4BbDygWAAKAAA


--=-DZky3f3xv7HfSXhPJroI--
