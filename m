Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 13:08:04 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:34030 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823049Ab3FTLHyd2DIn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 13:07:54 +0200
Received: by mail-la0-f51.google.com with SMTP id fq12so5426083lab.24
        for <linux-mips@linux-mips.org>; Thu, 20 Jun 2013 04:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=tel3KIo6bcTH13o0EnI4T0Wi9+KFuVTxboJkR5U5QE8=;
        b=pvp/+tRTax3QaLe5zHy/JQDePnfUdQmajxdgnvlU2VqFd9tDaU7kJcAbU7YURaC5Sf
         BsBr+Nw5Pyd6FGkhCQhhQmpfqj9z3Gr+dRwbSb0i7oMzN0/C2QeBwV+EmCmkiJeG4p9E
         QDNBrSUY6nA8gY4nZ86tbP6Hg6IToJXDQjGczBT2DLWyuT2KOJJAciURQ2jSnGEc2DQd
         RCaRWEH7JcEenfzJtw1wjQqE3ZFnfUg0/i17u3u7qVIY4l3KvzifNRlI8wNer6kBacQN
         TIxPTa9yKiPi7Vvv7WEIvnoHuMbEt1uuJjjKNIwOj8/l2RRztW6DS5YfvHMzfyzV2Xw0
         kVKA==
X-Received: by 10.152.3.74 with SMTP id a10mr3420970laa.74.1371726468886;
        Thu, 20 Jun 2013 04:07:48 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-149-191.pppoe.mtu-net.ru. [91.76.149.191])
        by mx.google.com with ESMTPSA id et10sm167723lbc.6.2013.06.20.04.07.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 04:07:47 -0700 (PDT)
Message-ID: <51C2E286.3070400@cogentembedded.com>
Date:   Thu, 20 Jun 2013 15:07:50 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: malta: Update GCMP detection.
References: <1371706601-5205-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1371706601-5205-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnyc20JBEM4nIadVuySWsTFSXRrQ7mIuUDe1LP0729vwcnbn6TYVTWVDsCkPSpONG2k5WYX
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 20-06-2013 9:36, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

> Add GCMP detection for IASim Marvell chip emulation support.

> Change-Id: I4a39fbc52bc55d7b3fe48340bc5c746395552e1f

    Same comment on this line as on linux-ide just now. Remove it please.

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

WBR, Sergei
