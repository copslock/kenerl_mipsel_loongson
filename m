Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 11:03:36 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34988 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028400AbcEYJDeVf2F1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 11:03:34 +0200
Received: by mail-pa0-f42.google.com with SMTP id tb2so15901033pac.2
        for <linux-mips@linux-mips.org>; Wed, 25 May 2016 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VpVQ5sjT50gzM4Vh4vZAKAaeESxjG6M2hMI3zfNNLQ=;
        b=O4jXr4w70573NqcOnK4/ZecRPh/HP7L5FXd3/tWqsCB7s2pXJ8HPt4OPMRMcLV6XY/
         gsVQuT+djxXWIUtJermXp31klFJup8mhtL3a7E4ybMWDhCqz0UTUQBrkkhE2iTcdh7a4
         SMgpw0kOvuT/Z8f6YXcqIsia9z6o3b9n2bg2FtksHODHqAxeDB7xRDYKMC51aGPgz5FT
         NvwBBu+UE9wZ6Y3FiWXjaZftEkHZxdS1p3Ka+1Tm8bAweXgqGfvJtWcRv4WHk1YHWyaE
         Jp580xsiPLSyXghmAWOcjpJWAvfUAn/b7BsdkBXCzlCoH/EQ/Atvrz6w2szzIWlnUin0
         9fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VpVQ5sjT50gzM4Vh4vZAKAaeESxjG6M2hMI3zfNNLQ=;
        b=U3XSSWpml1nF7YpGkzlp3WwZrZ8ohYZib4e/bB1cEQa+dSLdrPNXiO/t6vPuxZdMom
         Kn6L1gTUqVlTRtiClsXq4QqNYXJkPPBKZPS5PzwMk+HllFLPchuEg6FEC2ATzM/e2Xqw
         ZdClsNrJ9Z59eeNL1/g3O9TqSuAnSuAQdp0XBpmYO2hj1g9fjez3v5Tfzj+ckNJKcxfC
         Kr3qrngA6uDsKxucRzznwuw9iv0fV+rb3Q1N8tbxBfn1Y8jqSVnBXMsDcnlD1bJkKcaE
         tGAsmlfNtzQiCYl62ozYOTtTulECCO3VC3AOb7vFSzNFVcqlki8LTK5JmfyQEFyVawLm
         sS4w==
X-Gm-Message-State: ALyK8tJzJr8MN75cEaf0ZgiESPSVO/qxFwc/ExF8Wq91wgiYzZesgmSjDYCiTrXztih7+A==
X-Received: by 10.66.222.202 with SMTP id qo10mr2265376pac.141.1464147187756;
        Tue, 24 May 2016 20:33:07 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:f573:6891:973c:b422? ([2601:645:c200:33:f573:6891:973c:b422])
        by smtp.gmail.com with ESMTPSA id t8sm8468798paw.16.2016.05.24.20.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 20:33:07 -0700 (PDT)
Message-ID: <1464147185.27173.29.camel@chimera>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Date:   Tue, 24 May 2016 20:33:05 -0700
In-Reply-To: <20160525063105.85bfe3e0c4dde0b716981fb1@gmail.com>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
         <1464041521.5475.18.camel@chimera> <1464067930.27173.7.camel@chimera>
         <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
         <1464102907.27173.23.camel@chimera> <1464103650.27173.26.camel@chimera>
         <20160524194818.9e8399a56669134de4baee1e@gmail.com>
         <1464109249.27173.27.camel@chimera>
         <20160525063105.85bfe3e0c4dde0b716981fb1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Wed, 2016-05-25 at 06:31 +0300, Antony Pavlov wrote:
> On Tue, 24 May 2016 10:00:49 -0700
> Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> wrote:
> 
> > On Tue, 2016-05-24 at 19:48 +0300, Antony Pavlov wrote:
> > > Also we can drop '#if defined(CONFIG_*' in favour of 'if
> > > (IS_ENABLED(CONFIG_*'.
> > > 
> > > -- 
> > > Best regards,
> > >   Antony Pavlov
> > 
> > OK. Anything else?
> 
> I have nothing more to say just now.
> At the moment I don't use UHI-enabled bootloader.
> I'm planning to add UHI support to barebox bootloader (http://www.barebox.org)
> in a few weeks.
> 
> What bootloader do you use?
> 
> -- 
> Best regards,
>   Antony Pavlov

The device in question has a non-UHI u-boot, and OpenWrt/LEDE have to
append a DTB.
