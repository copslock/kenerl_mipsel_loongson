Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 10:41:34 +0200 (CEST)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35074 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006865AbcEYIldOwYM1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 May 2016 10:41:33 +0200
Received: by mail-lf0-f47.google.com with SMTP id w16so3101256lfd.2
        for <linux-mips@linux-mips.org>; Wed, 25 May 2016 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrs9buI419aKYJx+80E74Ok6Hu12gj9XO8q5Ddlay6c=;
        b=0hgPlZovNg2Mfz9StPAZOmpamZTOlJAzU2/Lj9febrj4Q4mNArtiHdSFGC61qDQZIJ
         DfOTr+81eAyVelIZZxtQalWsF6ucJVEiXKdcdZw5osrZlYeD2XSXhhaXRK2morNIvbLy
         VVGIXYe9hqsgjnjWTrv4twQneCcWV3WNaNSNPFzE6J9HhNX8w/5f8kDHIzBBMwr0TgnB
         cbOqVDANsX7t+kG++cScZekYvM6iX/RiBxgocsE545RVxDkpVBMkip14SI6nIfljhzK7
         LkbiZa91iPJuexYE4gz1eekp/PRUweTDFlFQOc8kYwcfM0P1tpDXw24btH7F4/Ejf2p1
         cEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrs9buI419aKYJx+80E74Ok6Hu12gj9XO8q5Ddlay6c=;
        b=UN1klRVcoCOlQ5Z+yUyv3PAqMZKwV5Fyafrk/SbQgunVRkTKhr58aJUMQZC3tehipK
         yWaRzDae0ShLq296/z2BFIWGPvlIQv0ALDftOBsUD5fskqWsm7zuHCaMaQtT2IX2RKmK
         VWbYMOMxSQB63RyYtK8Poa/moVLUr1QVdvuAVxPDeWepbYwyveUXnKocz2CeaYSjm1TN
         DlF90WG4S+/8vrsbhyLLDJQiNvfXDuGKsl90oruzVii5M5NazVCmMHqlytrUUsRIV2dj
         brcIuDEJe+ysLZscj13dxBVtv1I0g3dD4TWrlQgdDiBhzFlkfdDO1Stoo5a2O+pckagU
         Rwmg==
X-Gm-Message-State: ALyK8tLtoLIzqlCJAvGABcyra0mkXGMqsrl9GfYn9+y4QpkwAlLHalROx3UzFUZXFdBP5w==
X-Received: by 10.25.216.234 with SMTP id r103mr253288lfi.192.1464147001690;
        Tue, 24 May 2016 20:30:01 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id d126sm1029023lfd.42.2016.05.24.20.30.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 20:30:00 -0700 (PDT)
Date:   Wed, 25 May 2016 06:31:05 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
Message-Id: <20160525063105.85bfe3e0c4dde0b716981fb1@gmail.com>
In-Reply-To: <1464109249.27173.27.camel@chimera>
References: <574372CD.1060201@hauke-m.de>
        <5743777F.9060801@hauke-m.de>
        <1464041521.5475.18.camel@chimera>
        <1464067930.27173.7.camel@chimera>
        <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
        <1464102907.27173.23.camel@chimera>
        <1464103650.27173.26.camel@chimera>
        <20160524194818.9e8399a56669134de4baee1e@gmail.com>
        <1464109249.27173.27.camel@chimera>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Tue, 24 May 2016 10:00:49 -0700
Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> wrote:

> On Tue, 2016-05-24 at 19:48 +0300, Antony Pavlov wrote:
> > Also we can drop '#if defined(CONFIG_*' in favour of 'if
> > (IS_ENABLED(CONFIG_*'.
> > 
> > -- 
> > Best regards,
> >   Antony Pavlov
> 
> OK. Anything else?

I have nothing more to say just now.
At the moment I don't use UHI-enabled bootloader.
I'm planning to add UHI support to barebox bootloader (http://www.barebox.org)
in a few weeks.

What bootloader do you use?

-- 
Best regards,
  Antony Pavlov
