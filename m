Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2006 11:51:25 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8162 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133859AbWCVLvP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Mar 2006 11:51:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.5/8.13.4) with ESMTP id k2MC171a007673;
	Wed, 22 Mar 2006 12:01:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.5/8.13.5/Submit) id k2MC15tG007672;
	Wed, 22 Mar 2006 12:01:05 GMT
Date:	Wed, 22 Mar 2006 12:01:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Au1xx0: OHCI region size off-by-one
Message-ID: <20060322120105.GB4544@linux-mips.org>
References: <441F4EBB.6000906@ru.mvista.com> <20060321010229.GL12676@deprecation.cyrius.com> <441F5147.6000509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441F5147.6000509@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 21, 2006 at 04:05:11AM +0300, Sergei Shtylylov wrote:

> >... and please post your patches inline rather than as MIME
> >attachments. :)
> 
>    My mailer will stuff tabs with spaces then, and I know text/plain 
> attachments are considered OK.

Well, the topic isn't new but here is some wisdom from others on how to
post patches with the various wannabe mail clients like Mozilla.

Quoting from Alan Cox:

> For Evolution
> 
> Set the formatting to "Preformat"
> Hit Insert/Text File (Alt-I X)
>         Then at the ghastly gnome dialog hit ^L (secret handshake for the
> 'developers cant stand it either' shortcut box) and type in the file
> name

And here some wisedom from Randy Dunlap on Thunderbird:

>> Randy D. eventually agreed that there was a way, IIRC:
>>
>> http://lkml.org/lkml/2005/12/27/191
>>
>> Probably can work your way through the thread to figure out how (I use mutt :)
> Yep, the odd part is not to disable html email.
> Then when composing a message, there is a drop-down box for a format
> selection.  While the cursor is in the body area, change the format
> from default "Body text" to Preformat, and then copy-n-paste the patch.
> At least that's what worked for me.

And Frank Sorenson:

> Here is one method for posting patches in Thunderbird:
>
> Before starting to write the email, do Edit->Preferences, Composition
> tab, change "Wrap plain text messages at __ characters" to 0
>
> Begin writing your email
> 
> Start up an editor in which you can select the text, for example:
> # gvim patch.diff
> Edit->Select All
> Edit->Copy
>
> Switch back to the open Compose window, then Edit->Paste
>
> If you have Enigmail configured, when sending the email, you might get a
> box asking if you want to change the line wrapping to 68 characters, so
> just say No if that happens.

Others have suggested using an external editor which will show up in the
compose editor and allow to include the patch file inline.

Here's Martin Bligh's page on the topic:

  http://mbligh.org/linuxdocs/Email/Clients/Thunderbird

Credits for anybody would writes some useful docs for the linux-mips wiki
on this topic - unfortunately it's really high in demand.  I'd do it
myself - but I am a mutt + vi user :-)

  Ralf
