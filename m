Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 17:03:05 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.228]:20632 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039281AbXBMRDB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 17:03:01 +0000
Received: by qb-out-0506.google.com with SMTP id e12so787366qba
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 09:01:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X0JJHqD9D6E5CKz1qCXIlREQSGnTT7Kij7mmv9pprDVEzmbfEIcTq85tCewSpoBseLm7oQIn3wLGth9hcxs9WGlSpEU0j/r8v6kvOi3xz3gfvv/Bp/wFnQs2rzOD/XQMRhgIuaIUGi/xtA3jqjk7cvMQ1bqbSE6G86uPk/vfJEE=
Received: by 10.114.60.19 with SMTP id i19mr7910538waa.1171386116763;
        Tue, 13 Feb 2007 09:01:56 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Tue, 13 Feb 2007 09:01:56 -0800 (PST)
Message-ID: <cda58cb80702130901l62d5bf7if5b7730ba24460f3@mail.gmail.com>
Date:	Tue, 13 Feb 2007 18:01:56 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] fix irq handling of DECstations
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20070213152716.GA4942@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070212.234826.59032634.anemo@mba.ocn.ne.jp>
	 <20070213022548.GB25323@linux-mips.org>
	 <45D1C21A.9070801@innova-card.com>
	 <20070213152716.GA4942@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/13/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Feb 13, 2007 at 02:50:18PM +0100, Franck Bui-Huu wrote:
>
> > This patch makes these routines a lot more readable whatever
> > the value of CONFIG_PREEMPT.
>
> Applied.

argh there's a small mistake. Could you amend this fix ?

-- >8 --

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index c7429b2..0b78fcb 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -31,7 +31,7 @@
 #ifndef CONFIG_PREEMPT
 FEXPORT(ret_from_exception)
 	local_irq_disable			# preempt stop
-	b	_ret_from_irq
+	b	__ret_from_irq
 #endif
 FEXPORT(ret_from_irq)
 	LONG_S	s0, TI_REGS($28)
