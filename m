Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA17640; Sun, 11 May 1997 15:47:49 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA05418 for linux-list; Sun, 11 May 1997 15:47:13 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA05342 for <linux@engr.sgi.com>; Sun, 11 May 1997 15:47:00 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA29532
	for <linux@engr.sgi.com>; Sun, 11 May 1997 15:46:57 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id SAA11805 for linux@engr.sgi.com; Sun, 11 May 1997 18:56:36 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705112256.SAA11805@neon.ingenia.ca>
Subject: irix_times
To: linux@cthulhu.engr.sgi.com
Date: Sun, 11 May 1997 18:56:35 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>From sysirix.c:

asmlinkage int irix_times(struct tms * tbuf)
{
        int error;
        lock_kernel();
        if (tbuf) {
                int error = verify_area(VERIFY_WRITE,tbuf,sizeof
*tbuf);
                if (error)
                        goto out;
                __put_user(current->utime,&tbuf->tms_utime);
                __put_user(current->stime,&tbuf->tms_stime);
                __put_user(current->cutime,&tbuf->tms_cutime);
                __put_user(current->cstime,&tbuf->tms_cstime);
        }
        error = 0;

out:
        unlock_kernel();
        return error;
}

gcc tells me, quite rightly, that error may be used without
initialization, and I'm wondering if the hiding of error in the C<if
(tbuf)> block is intentional.

I assume not, but I thought I'd make sure it just wasn't davem
outsmarting me again. =)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                   Welcome to the technocracy.
#>                                                                     
#> "you'd be so disappointed
#>              to find out that the magic was not
#>                          really meant for you" - OLP
