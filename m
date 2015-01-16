Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 19:00:14 +0100 (CET)
Received: from mail-we0-f180.google.com ([74.125.82.180]:63615 "EHLO
        mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbAPSANl6Jlj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 19:00:13 +0100
Received: by mail-we0-f180.google.com with SMTP id w62so21559835wes.11;
        Fri, 16 Jan 2015 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=mgcBpszNLVc1BAX1GKcyyP298XkK0H7WUdPY/3fx4OI=;
        b=pY+nCFxWfX4yTerBYJho4SAtecjpicravyUSgtJSicvoGsqfqN6uqqosCk9R+ydYV6
         s+a8aSAYVa5GZ986ZYPGThsunyiBReudloix3X1LKmJ08Sf5NmbT3KFHGm2uecFdqVvQ
         I+jBTT5rFR4LAu8u45jhS4CNmWq4MA4ewBMCqP20tgLlN4XjM0C8kFAYK3xQtQEV4CYs
         +StyX95r6AaYeqjj6FgEmnfYmd3kLURlxSHQcOMuAB9QqIjn2gmkWSl6Hw0AvzuVb2yr
         aRmNjd5yF++aOi9iRQeRN1Tg5bSASg5bYHc2LWkJFI2Om1iGVYRTvbgnZVCl9pQotMEI
         JwiQ==
X-Received: by 10.180.77.114 with SMTP id r18mr8616448wiw.8.1421431208426;
 Fri, 16 Jan 2015 10:00:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.105.144 with HTTP; Fri, 16 Jan 2015 09:59:26 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 16 Jan 2015 18:59:26 +0100
Message-ID: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
Subject: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
To:     Paul Burton <paul.burton@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Hi Paul,

Your patch commit 90cee759f08a6b7a8daab9977d3e163ebbcac220
("MIPS: ELF: Set FP mode according to .MIPS.abiflags") completely
breaks my pure soft-float o32 userland:

[...]
Freeing unused kernel memory: 244K (80993000 - 809d0000)
Failed to execute /usr/lib/systemd/systemd (error -84).  Attempting defaults...
Starting init: /sbin/init exists but couldn't execute it (error -84)
sh: cannot set terminal process group (-1): Inappropriate ioctl for device
sh: no job control in this shell
sh-4.3# ls
sh: /bin/ls: Accessing a corrupted shared library
sh-4.3#

I've recently rebuilt bash, ncurses, readline and glibc-2.20 (with
binutils 2.25+)
to track down another userland issue, so that may explain why at least
sh is able to run.

Reverting the patch fixes it for me.


Thanks!
      Manuel
