Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2004 18:07:09 +0100 (BST)
Received: from mx2.idealab.com ([IPv6:::ffff:64.208.8.4]:24848 "EHLO
	indiana.idealab.com") by linux-mips.org with ESMTP
	id <S8225539AbUDBRHJ>; Fri, 2 Apr 2004 18:07:09 +0100
Received: (qmail 86564 invoked by uid 72); 2 Apr 2004 17:06:58 -0000
Received: from baitisj@evolution.com by indiana.idealab.com by uid 70 with qmail-scanner-1.20rc1 
 (sweep: 2.14/3.73.  Clear:RC:1:. 
 Processed in 0.024167 secs); 02 Apr 2004 17:06:58 -0000
X-Qmail-Scanner-Mail-From: baitisj@evolution.com via indiana.idealab.com
X-Qmail-Scanner: 1.20rc1 (Clear:RC:1:. Processed in 0.024167 secs)
Received: from unknown (HELO powerpuff.evo1.pas.lab) (10.1.22.10)
  by 0 with SMTP; 2 Apr 2004 17:06:58 -0000
Subject: PATCH: drivers/sound/ite8172.c, versus kernel_2_4_24
From: Jeffrey Baitis <baitisj@evolution.com>
Reply-To: baitisj@evolution.com
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Evolution Robotics
Message-Id: <1080925619.25555.2.camel@powerpuff.evo1.pas.lab>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Apr 2004 09:06:59 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <baitisj@evolution.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Here's a patch to make the ITE8172 sound driver compile on the
kernel_2_4_24 branch.

-- drivers/sound/ite8172.c     30 Mar 2004 01:38:00 -0000      1.1.1.1
+++ drivers/sound/ite8172.c     2 Apr 2004 17:02:01 -0000
@@ -2180,7 +2180,7 @@
        release_region(s->io, pci_resource_len(dev,0));
        unregister_sound_dsp(s->dev_audio);
        unregister_sound_mixer(s->codec->dev_mixer);
-       ac97_codec_release(s->codec);
+       ac97_release_codec(s->codec);
        kfree(s);
        pci_set_drvdata(dev, NULL);
}

-Jeff
