Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 22:59:37 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50469 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816886AbaFLU7ejXZok (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2014 22:59:34 +0200
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4604721037;
        Thu, 12 Jun 2014 16:59:33 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 12 Jun 2014 16:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=flWCGK81Whrek3DqyLqPbU/1NUE=; b=AIcQwwMIWDIvu/Ip4iTismOEKfzd
        65cHBVDDkBI/WmsSc2mw0j6lnJx7T/3VI3KN5PQJnoXDzkc6eb8XFBnrylCJKzal
        2aqnawnGZw1R8NZbCtZQzapZtVhNm/UkuzMReRyFdnhKm3n5mJ/pTJAQBoYxxNvK
        1BsevDrtngxjnpw=
X-Sasl-enc: sjnBeOYMPwiL47e2V8Z0DlEQZQ4s8JP3K6rzSMTeu1eM 1402606772
Received: from localhost (unknown [76.28.255.20])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9C636801C6;
        Thu, 12 Jun 2014 16:59:32 -0400 (EDT)
Date:   Thu, 12 Jun 2014 14:03:23 -0700
From:   Greg KH <greg@kroah.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable <stable@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, 751417@bugs.debian.org,
        team@security.debian.org, Plamen Alexandrov <plamen@aomeda.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: Bug#751417: linux-image-3.2.0-4-5kc-malta: no SIGKILL after
 prctl(PR_SET_SECCOMP, 1, ...) on MIPS
Message-ID: <20140612210323.GA30046@kroah.com>
References: <20140612161903.32229.20589.reportbug@debian-mips."">
 <1402601767.31756.38.camel@deadeye.wl.decadent.org.uk>
 <1402604501.31756.50.camel@deadeye.wl.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1402604501.31756.50.camel@deadeye.wl.decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Jun 12, 2014 at 09:21:41PM +0100, Ben Hutchings wrote:
> On Thu, 2014-06-12 at 20:36 +0100, Ben Hutchings wrote:
> > Control: tag -1 security upstream patch moreinfo
> > Control: severity -1 grave
> > Control: found -1 3.14.5-1
> 
> Aurelien Jarno pointed out this appears to be fixed upstream in 3.15:
> 
> commit 137f7df8cead00688524c82360930845396b8a21
> Author: Markos Chandras <markos.chandras@imgtec.com>
> Date:   Wed Jan 22 14:40:00 2014 +0000
> 
>     MIPS: asm: thread_info: Add _TIF_SECCOMP flag
> 
> It looks like this can be cherry-picked cleanly onto stable branches for
> 3.13 and 3.14.  For 3.11 and 3.12, it will need trivial adjustment.
> 
> For branches older than 3.11, this needs to be cherry-picked first:
> 
> commit e7f3b48af7be9f8007a224663a5b91340626fed5
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Wed May 29 01:02:18 2013 +0200
> 
>     MIPS: Cleanup flags in syscall flags handlers.

It also needs parts of 1d7bf993e0731b4ac790667c196b2a2d787f95c3 (MIPS:
ftrace: Add support for syscall tracepoints.) to apply properly to stuff
older than 3.11.  But, I'm not so sure that is good to apply as that is
a whole new feature.

So I think I'll just do this "by hand" to get it to work properly...

thanks,

greg k-h
