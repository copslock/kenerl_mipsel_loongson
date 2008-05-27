Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 13:40:54 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:28586 "HELO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with SMTP
	id S20044053AbYE0Mkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 May 2008 13:40:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 493169634;
	Tue, 27 May 2008 14:40:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Pe7ZmiR+hAsU; Tue, 27 May 2008 14:40:49 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 3720BCEDB;
	Tue, 27 May 2008 14:40:49 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: kexec on mips - anyone has it working?
Date:	Tue, 27 May 2008 14:40:48 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org
References: <483BCB75.4050901@wpkg.org> <200805271405.55346.nschichan@freebox.fr>
In-Reply-To: <200805271405.55346.nschichan@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805271440.49034.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Tuesday 27 May 2008 14:05:54 Nicolas Schichan wrote:
>
> I am using a 2.6.20 kernel on a 32bit mips platform and it is working fine.
> however I am using this userland code (make CROSS=$(your cross-compiler
> prefix) to compile it) :

I can confirm it also works on our little-endian boards. the kexec-code 
between 2.6.25 and our tree is the same (I backported some patches).

I will give a try to the official userland stuff.

Btw, sorry for the mess caused by the HTML attachement in the previous mail.

Regards,

-- 
Nicolas Schichan
