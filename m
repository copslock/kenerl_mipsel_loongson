Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 20:53:20 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.189]:11499
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225002AbVCUUxF>; Mon, 21 Mar 2005 20:53:05 +0000
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DDTtZ-0004Kq-00
	for linux-mips@linux-mips.org; Mon, 21 Mar 2005 21:53:05 +0100
Received: from [80.171.18.61] (helo=d018061.adsl.hansenet.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DDTtY-00014f-00
	for linux-mips@linux-mips.org; Mon, 21 Mar 2005 21:53:04 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
To:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
Date:	Mon, 21 Mar 2005 21:51:21 +0100
User-Agent: KMail/1.7.1
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050320224028.GB6727@linux-mips.org> <423DFE7C.7040406@embeddedalley.com>
In-Reply-To: <423DFE7C.7040406@embeddedalley.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503212151.22059.eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Sunday 20 March 2005 23:51, Pete Popov wrote:
> It works and no one has complained about any bugs. 

I hereby do complain that it doesn't work. ;)

I'd give more details, but I'm neither at work nor did I investigate the 
situation properly. What I remember trying is to add 'console=/dev/ttyS0' or 
somesuch to the commandline, but couldn't get it to work there. The funny 
thing is that when I use the GDB support over serial line (which seems to use 
a primitive, stripped-down version of a serial driver) it works, I can then 
redirect boot messages via 'console=gdb'.

Uli
