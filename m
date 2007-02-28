Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 14:09:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:60158 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039318AbXB1OJU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2007 14:09:20 +0000
Received: from localhost (p5152-ipad28funabasi.chiba.ocn.ne.jp [220.107.204.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 73EA3B672; Wed, 28 Feb 2007 23:07:59 +0900 (JST)
Date:	Wed, 28 Feb 2007 23:07:59 +0900 (JST)
Message-Id: <20070228.230759.39154923.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: rbhma4500_defconfig
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45E44C89.4020105@ru.mvista.com>
References: <45E33E13.7010007@ru.mvista.com>
	<20070227.235804.108739157.anemo@mba.ocn.ne.jp>
	<45E44C89.4020105@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 27 Feb 2007 18:21:45 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > I have not tried recently.  I'll try later, but what's the problem?
> 
>     No console output, IIRC.

CONFIG_SERIAL_TXX9_CONSOLE=y
CONFIG_SERIAL_TXX9_STDSERIAL=y

and

CONFIG_VGA_CONSOLE=n
CONFIG_KEYBOARD_ATKBD=n
CONFIG_SERIO_I8042=n

Would help?
---
Atsushi Nemoto
