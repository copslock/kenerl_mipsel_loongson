Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2008 00:46:13 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47844 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S24208221AbYLSAqL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Dec 2008 00:46:11 +0000
Date:	Fri, 19 Dec 2008 00:46:11 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
In-Reply-To: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0812190041080.6463@ftp.linux-mips.org>
References: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 17 Dec 2008, David Daney wrote:

> This is an incomplete proof of concept that I applied to be able to
> build a 64 bit kernel with GCC-4.4.  It doesn't handle the 32 bit case
> or the R4000_WAR case.

 The R4000_WAR case can use the same C code -- GCC will adjust code 
generated as necessary according to the -mfix-r4000 flag.  For the 32-bit 
case I think the conclusion was the only way to get it working is to use 
MFHI explicitly in the asm.

  Maciej
