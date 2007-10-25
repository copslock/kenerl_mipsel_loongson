Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 21:02:31 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:29544 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20027076AbXJYUCX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 21:02:23 +0100
Received: by py-out-1112.google.com with SMTP id p76so1080332pyb
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 13:02:12 -0700 (PDT)
Received: by 10.65.180.9 with SMTP id h9mr4711630qbp.1193342531777;
        Thu, 25 Oct 2007 13:02:11 -0700 (PDT)
Received: by 10.65.123.7 with HTTP; Thu, 25 Oct 2007 13:02:11 -0700 (PDT)
Message-ID: <dd7dc2bc0710251302j776cfd03od54ca495bd6e37ad@mail.gmail.com>
Date:	Fri, 26 Oct 2007 05:02:11 +0900
From:	"Hyon Lim" <alex@alexlab.net>
To:	linux-mips@linux-mips.org
Subject: Problem with porting SwSusp to MIPS
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3573_18604541.1193342531773"
Return-Path: <alex@alexlab.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alexlab.net
Precedence: bulk
X-list: linux-mips

------=_Part_3573_18604541.1193342531773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm working on SwSusp mips version.
But, I have a problem restore and save processor context.

This is the porting guide that I referenced.

http://tree.celinuxforum.org/CelfPubWiki/SwSuspendPortingNotes

I implemented

__save_processor_state(&saved_context);
__restore_processor_state(&saved_context);

But,

int swsusp_arch_suspend(void);
int swsusp_arch_resume(void);

are not.

Is there any person who have an experience same as me?
or any patch URL exists?

------=_Part_3573_18604541.1193342531773
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I&#39;m working&nbsp;on SwSusp mips version.</div>
<div>But, I have a problem restore and save processor context.</div>
<div>&nbsp;</div>
<div>This is the porting guide that I referenced.</div>
<div>&nbsp;</div>
<div><a href="http://tree.celinuxforum.org/CelfPubWiki/SwSuspendPortingNotes">http://tree.celinuxforum.org/CelfPubWiki/SwSuspendPortingNotes</a></div>
<div>&nbsp;</div>
<div>I implemented</div>
<div>&nbsp;</div>
<div>__save_processor_state(&amp;saved_context); <br>__restore_processor_state(&amp;saved_context);</div>
<div>&nbsp;</div>
<div>But, </div>
<div>&nbsp;</div>
<div>int swsusp_arch_suspend(void);</div>
<div>int swsusp_arch_resume(void);</div>
<div>&nbsp;</div>
<div>are not.</div>
<div>&nbsp;</div>
<div>Is there any person who have an experience same as me?</div>
<div>or any patch URL exists?</div>

------=_Part_3573_18604541.1193342531773--
