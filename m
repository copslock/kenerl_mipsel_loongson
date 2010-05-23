Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 14:05:11 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:36931 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491790Ab0EWMFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 14:05:08 +0200
Received: by pxi1 with SMTP id 1so1142461pxi.36
        for <linux-mips@linux-mips.org>; Sun, 23 May 2010 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=nZ5u3RkBqxpaIbbwpfjprBkKTmjznc9qFWfKhVwA4bQ=;
        b=N4Mc/a16NWY2rA9p1r82WOaUCjvv4QTK9xL157tclLJCke92hfE/HmX8ViU79NzUgm
         dX6QqeZY3BvrRFZQtDUOI/HPQ/DMGea4bsQ666DMbVEnejXp8UPuBGPBXsGNfpekGtRC
         0ZE5FjXFsTkn6RDhYL2tJAfJtSLVucsOP7BU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lwLVTghLuXX4wOXlEeiLbJvS4T7sjZlGmpn4torMFCmjJC5s+VvEodwOPPuwvLVMa/
         aqUuiX7fhpArjuMp7pMl6c23oA8J+37e19eOFt8eb8S7Kp2CLKAkKNZLW7TdyvNZA209
         WQWdL887FN6QRXsgFEtJJCEPDxwdoQ82WbSUM=
MIME-Version: 1.0
Received: by 10.141.100.15 with SMTP id c15mr3008786rvm.221.1274616299675; 
        Sun, 23 May 2010 05:04:59 -0700 (PDT)
Received: by 10.140.132.16 with HTTP; Sun, 23 May 2010 05:04:59 -0700 (PDT)
Date:   Sun, 23 May 2010 22:04:59 +1000
Message-ID: <AANLkTilyX-Aaxbpok3qh_qr-VGbVyL5ltNkqVZsvuzmU@mail.gmail.com>
Subject: SGI Indy - HAL2 digital audio
From:   Tom McAvaney <tjmcavaney@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <tjmcavaney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tjmcavaney@gmail.com
Precedence: bulk
X-list: linux-mips

Hello all,

I am having some trouble figuring out how to enable digital audio
output on my R5000 Indy running Debian Squeeze (2.6.32 kernel).

The HAL2 module is loaded and I can get analog audio from the
headphone jack fine. The problem is that when I try the digital audio
out jack, I hear the boot tune (hooray!) but then once the system is
up I only get audio from the internal speaker.

aplay -l gives me the following:

**** List of PLAYBACK Hardware Devices ****
card 0: Audio [SGI HAL2 Audio], device 0: SGI HAL2 Audio [SGI HAL2]
 Subdevices: 1/1
 Subdevice #0: subdevice #0

cat /proc/asound/devices gives me:

 0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer


aplay hw:0,0 test.wav   plays audio ... but from the internal speaker (!)

Perhaps as a first step, can someone confirm whether pcm digital audio
is working on the HAL2?

Many thanks for any pointers!

(I have also posted this to debian-mips, but figured there might be
more eyeballs here).

Tom
