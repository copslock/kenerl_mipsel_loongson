Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 00:14:43 +0100 (BST)
Received: from rv-out-0910.google.com ([209.85.198.184]:60882 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024856AbXITXOf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 00:14:35 +0100
Received: by rv-out-0910.google.com with SMTP id l15so532635rvb
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 16:14:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=mSFbYjquv16THBkk/3MQltXDNns0h/KXX6bdS/R1WPI=;
        b=H8vAf3e/UP1/WJo0wzaoZY9WnXcSu0hZye70ecx2YusFrjb2ZH8lEtFkMiCKTbtG80CSZyliG5RG48lyvkD3vV3cAJgJ00yB0EzcvLo/HB4jUIPFpiq49N2b6+4wCKiTYz0xxVsN5Kp/v+VeOucRIdZ6WPIJ8tPdN++L9CyiFcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pdT+fkeK96ChEKwJJxtzCOkeoaBRsQO6RClH6AW+quGgEtoW8lhl+3b6keIr7M2QzdWxgJ9Wep6e9XnCT2rbAaH/HDMh+r/qs59cF8O08I3n9INyZvbu+KbFmxxXLXqWG95iUyF6xBmODM2uWy4aqq/BwCKGMBYrsGtP+T15z/U=
Received: by 10.114.153.18 with SMTP id a18mr2723171wae.1190330055874;
        Thu, 20 Sep 2007 16:14:15 -0700 (PDT)
Received: by 10.141.75.4 with HTTP; Thu, 20 Sep 2007 16:14:15 -0700 (PDT)
Message-ID: <48413e3e0709201614pd8fc58dga6354d5d2330f288@mail.gmail.com>
Date:	Thu, 20 Sep 2007 16:14:15 -0700
From:	"Winson Yung" <winson.yung@gmail.com>
To:	linux-mips@linux-mips.org
Subject: MIPS assembly question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <winson.yung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: winson.yung@gmail.com
Precedence: bulk
X-list: linux-mips

Hi there, I have some general mips inline assembly question regards to
32 bit atomic operation, here a section of its assembly
implementation:

                "       .set    mips3                                   \n"
                "1:     ll      %0, %2                  # __cmpxchg_u32 \n"
                "       bne     %0, %z3, 2f                             \n"
                "       .set    mips0                                   \n"
                "       move    $1, %z4                                 \n"
                "       .set    mips3                                   \n"
                "       sc      $1, %1                                  \n"
                "       beqzl   $1, 1b                                  \n"

Questions:

1) what does 'z' mean in the line of 'bne %0, %z3, 2f'?
2) Is $1 suppose to be use as an constant 1, I don't understand the
line 'sc  $1, %1'

Will appreciate if someone can point out to me a good tutorial on
explaining these little things.

Thanks!
/Winson.
