Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 10:42:14 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.230]:36025 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20035162AbYG2JmF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 10:42:05 +0100
Received: by wr-out-0506.google.com with SMTP id 58so5981941wri.8
        for <linux-mips@linux-mips.org>; Tue, 29 Jul 2008 02:42:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=B4K9+uOCaTi1jNWalT2u4mImhCygQch1wU97Hl8x+WQ=;
        b=hstPCMGc1p141XfMeNWPq+LFBOT6We/GyHnEtsy9w1KAGzNpYmHPEHTxD9kFxQXebu
         gfqfoRg7XfCs8ckoKPtaNCXJsPDFooHvcIFni7VAMXBzW1iSftgquEv18k1A5+/vE71j
         v5uXjG6R+Ne1dPLOgrBLjt4xikH7/JlfoUFos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=SwMfQuAmiR9D2R+jAOBHBxofOy9j8OoFlyH2+MJzx+c+0RriLh5OM58Pq2n+SICzm5
         onK3K1B6qV1WJHXfFbanFT/Qi7MFLUlvLnmX34axL7Ls+bQHQpZMvDsIaKNYu2bwH60r
         fXdNTmWiVYX4neKq7DqNViaK3yk//SuZsRr24=
Received: by 10.90.91.2 with SMTP id o2mr8996514agb.111.1217324523291;
        Tue, 29 Jul 2008 02:42:03 -0700 (PDT)
Received: from ?192.168.2.149? ( [88.208.94.142])
        by mx.google.com with ESMTPS id y56sm10398328hsb.0.2008.07.29.02.42.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jul 2008 02:42:02 -0700 (PDT)
Message-ID: <488EE5F0.7020302@gmail.com>
Date:	Tue, 29 Jul 2008 11:42:08 +0200
From:	Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080720)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Char: ds1286, eliminate busy waiting
References: <1217008198-17143-1-git-send-email-jirislaby@gmail.com> <20080728230533.GB1430@linux-mips.org>
In-Reply-To: <20080728230533.GB1430@linux-mips.org>
X-Enigmail-Version: 0.95.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jirislaby@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle napsal(a):
> On Fri, Jul 25, 2008 at 07:49:58PM +0200, Jiri Slaby wrote:
> 
>> ds1286_get_time(); is not called from atomic context, sleep for 20 ms is
>> better choice than a (home-made) busy waiting for such a situation.

> Looks ok to me I guess.  Though I don't really think it matters ...

I think RT people has different opinion ;).

> The same condition also appears in drivers/char/rtc.c and maybe a few
> others.  Rtc.c has been copies and modified several times.

In rtc.c there is something completely different:
         while (rtc_is_updating() != 0 &&
                time_before(jiffies, uip_watchdog + 2*HZ/100))
                 cpu_relax();

It's a conditional busy-waiting. It reads the rtc status after each busy 
cycle while in the ds1286 there was
         if (ds1286_is_updating() != 0)
                 while (time_before(jiffies, uip_watchdog + 2*HZ/100))
                         barrier();
