Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Oct 2004 10:47:14 +0100 (BST)
Received: from mailout06.sul.t-online.com ([IPv6:::ffff:194.25.134.19]:9651
	"EHLO mailout06.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8224918AbUJ1JrJ>; Thu, 28 Oct 2004 10:47:09 +0100
Received: from fwd03.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1CN6s7-0002WJ-08; Thu, 28 Oct 2004 11:47:07 +0200
Received: from denx.de (TEVHsOZJQeCbdyoZcHcA7FqZMyQgvX+TXr5LMUfJDyQnE2oW8owA4h@[217.235.243.64]) by fmrl03.sul.t-online.com
	with esmtp id 1CN6s0-2GBdrc0; Thu, 28 Oct 2004 11:47:00 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 9FFA242D29; Thu, 28 Oct 2004 11:46:58 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 01124C146B; Thu, 28 Oct 2004 11:46:56 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id F239213D84B; Thu, 28 Oct 2004 11:46:56 +0200 (MEST)
To: ichinoh@mb.neweb.ne.jp
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Link error gcc3.3.1 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 28 Oct 2004 15:10:17 +0900."
             <1098943817.20703@157.120.127.3.DIONWebMail> 
Date: Thu, 28 Oct 2004 11:46:51 +0200
Message-Id: <20041028094656.01124C146B@atlas.denx.de>
X-ID: TEVHsOZJQeCbdyoZcHcA7FqZMyQgvX+TXr5LMUfJDyQnE2oW8owA4h@t-dialin.net
X-TOI-MSGID: a84421ac-a339-4d24-b87b-5349e3313e39
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <1098943817.20703@157.120.127.3.DIONWebMail> you wrote:
> 
> Compiling source codes when using gcc3.3.1, I encounter the link error.
...
> /home/mvista/u-boot-1.1.1-mips1022/cpu/mips/start.S:247: Error: Cannot branch to undefined symbol.

Please see http://www.spinics.net/lists/mips/msg16534.html
or go directly to http://sources.redhat.com/ml/binutils/2004-04/msg00476.html

Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Contrary to popular belief, thinking does not cause brain damage.
