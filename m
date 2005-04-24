Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Apr 2005 20:37:07 +0100 (BST)
Received: from mailfe10.tele2.se ([IPv6:::ffff:212.247.155.33]:6626 "EHLO
	swip.net") by linux-mips.org with ESMTP id <S8224913AbVDXTgw>;
	Sun, 24 Apr 2005 20:36:52 +0100
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
Received: from [213.102.193.221] (HELO [192.168.0.32])
  by mailfe10.swip.net (CommuniGate Pro SMTP 4.3c5)
  with ESMTP id 142414783 for linux-mips@linux-mips.org; Sun, 24 Apr 2005 21:36:45 +0200
Message-ID: <426BF548.3030005@astek.fr>
Date:	Sun, 24 Apr 2005 21:36:40 +0200
From:	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: O2 IP32: patch for ALSA sound for 2.6.12rc2 (2)
References: <426BBC6E.5010603@laposte.net>
In-Reply-To: <426BBC6E.5010603@laposte.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ftemporelli@astek.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ftemporelli@astek.fr
Precedence: bulk
X-list: linux-mips

more comments about previous patch:
following problems have been reported when compiling static driver:
- "mace" musn't be defined in the driver => just comment line 112 in 
sgio2audio.c
- AD1843 init may be done twice (or more) to get it working... but 
driver can't be launch again when static...

Kumba, can you replace alsa_card_sgio2audio_init in sgio2audio.c with 
following code ?
(not really nice, but should do the trick when AD1843 won't go ahead)
====================================================
/* initialization of the module */
#include <linux/delay.h>
static int __init alsa_card_sgio2audio_init(void)
{
        int err,tries;
        tries=0;
        while(tries<5){
                if ((err = snd_sgio2audio_probe()) < 0) {
                        printk("sgio2audio: probe SGI O2 Audio 
#%d\n",tries);
                        tries++;
                        msleep(1000);
                }
                else{
                        printk("sgio2audio: SGI O2 Audio probed - OK\n");
                        return 0;
                }
        }
        printk("sgio2audio: sorry, SGI O2 Audio can't be initialized\n");
        return err;
}
====================================================

Fred
