Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 06:09:54 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:50048 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021356AbXFFFJw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 06:09:52 +0100
Received: (qmail 2220 invoked by uid 511); 6 Jun 2007 05:16:59 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 05:16:59 -0000
Message-ID: <4666418C.9040401@lemote.com>
Date:	Wed, 06 Jun 2007 13:09:32 +0800
From:	Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Mailing patches
References: <20070604133551.GA24405@linux-mips.org> <4664DB12.80906@gentoo.org> <20070605152338.GA22937@linux-mips.org>
In-Reply-To: <20070605152338.GA22937@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

sorry for the mess，when git-format-patch , wo forgot the -n para
and i would like to know what command para is recommended for sending
patch on maillist?

git-send-email --no-chain-reply-to --compose --from tiansm@lemote.com 
--no-signed-off-by-cc --smtp-server <server> --subject "Lemote Loongson 
2E patch update" --suppress-from --to linux-mips@linux-mips.org 00*

--no-chain-reply-to or --chain-reply-to ?

and.....should i resend the patches?

Tian



Ralf Baechle wrote:
> On Mon, Jun 04, 2007 at 11:40:02PM -0400, Kumba wrote:
>
>   
>> What about just attaching the patches to a message?  Seems like it'll avoid 
>> most of the problems Tbird has with them.  I'm just not sure if that 
>> hampers importing them into git or not.
>>     
>
> There are issues if people have the log message in the attachment as
> well.  And of course there is still the prime reason why attachments
> are a no-no - most mailers won't quote them so commenting on them is
> hard when discussing things.
>
> Git has some limited abilities to handle MIME messages since quite a
> while though.  But quilt which is the heart of how I manage the queue
> tree doesn't.
>
>    Ralf
>
>
>
>   
