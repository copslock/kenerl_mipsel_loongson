Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2005 16:59:22 +0100 (BST)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:7968
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225210AbVERP7F>;
	Wed, 18 May 2005 16:59:05 +0100
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 18 May 2005 08:58:58 -0700
Message-ID: <428B663C.7050308@avtrex.com>
Date:	Wed, 18 May 2005 08:58:52 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Michael Belamina <belamina1@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: 64 bit kernel for BCM1250
References: <20050518080917.45521.qmail@web32501.mail.mud.yahoo.com>
In-Reply-To: <20050518080917.45521.qmail@web32501.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 May 2005 15:58:58.0530 (UTC) FILETIME=[805D2C20:01C55BC2]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Michael Belamina wrote:
.
.
.
> Linux version 2.4.30 (michael@LinuxServer.lan) (gcc
> version 3.4.3) #29 SMP Wed May 18 10:37:00 IDT 2005
.
.
.
> 
> The fault is in do_pipe() function when trying to
> call:
> 
> struct inode *inode = new_inode(pipe_mnt->mnt_sb);
> 
> The pipe_mnt is NULL at this point because
> init_pipe_fs () was not called yet.
> 
> 
> Any ideas what could be wrong?
> 

I saw this with a 32 bit kernel (for a 32 bit target).  As far as I 
know, no 2.4.x kernels from linux-mips.org will work with gcc 3.4.x.

I have previously posted patches to this list that fixed the problem for 
me.  Specifically I think the messages in this thread are relevant:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=41AFDA18.2010906%40avtrex.com

David Daney.
