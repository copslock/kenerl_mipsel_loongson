Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 11:46:55 +0100 (CET)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:33395 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493373Ab1AQKqw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 11:46:52 +0100
Received: by qyk27 with SMTP id 27so5915332qyk.15
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 02:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=/A3t8tK5IjobtwL09yoRkOhhjq2N1nVd+6Excrqlr44=;
        b=g52vkoNCdWgbF77q0R8Jtav5spvXwpzf4BbNszYBAC8Q/6/5OH7xqDDMU2WoJZnVwD
         xiujRupmW+j1fAfJEOaAdgit7NQcgZbwnY86kA/fcnM2t/DF5FcWl3u9USRyELIUojyF
         OEzkKG8nzSrtc0SGiGxbDH5zx32vc/yyldEZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=tjqQChmRw1FEsq/mUinBYKYUyeCLVURzsmBaJvz3FNMlagiqPUqkPDD9lPs2Z+MWtQ
         0HpTcD7XvaW0OW46bRyVIxWGBH4ne8lNHMO5gWUfSjTZ0/83XoLnOLQgskewq7nR3sXM
         Itwba9DBncsqfoig3t8yehW/e7WcpNXCzbd5A=
Received: by 10.229.186.2 with SMTP id cq2mr3462140qcb.109.1295261205242; Mon,
 17 Jan 2011 02:46:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.39.9 with HTTP; Mon, 17 Jan 2011 02:46:25 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 17 Jan 2011 11:46:25 +0100
Message-ID: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
Subject: Merging SSB and HND/AI support
To:     Michael Buesch <mb@bu3sch.de>, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am currently looking into adding support for the newer Broadcom
BCM47xx/53xx SoCs. They require having HND/AI support, which probably
means merging the current SSB code and the HND/AI code from the
brcm80211 driver. Is anyone already working on this?

As far as I can see, there are two possibilities:

a) Merge the HND/AI code into the current SSB code, or

b) add the missing code for SoCs to brcm80211 and replace the SSB code with it.

The former is probably the less intrusive one, but requires a bit of
ssb-named-but-actually-not-ssb code unless one renames several
functions and structs.

The latter has the advantage of having a certain bus abstraction
already built-in, but would require adapting the b43 code to it. It
also looks like it doesn't support (very) old SoCs.

Regards,
Jonas

P.S: The Maintainers file says SSB's list is netdev, but I would have
expected it to be linux-wireless. Is this still correct?
