Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 11:28:49 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:34962
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeBLK2mMnQ09 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 11:28:42 +0100
Received: by mail-qk0-x244.google.com with SMTP id c4so15510040qkm.2
        for <linux-mips@linux-mips.org>; Mon, 12 Feb 2018 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I2+6zjz21uipfp2QCPCdKXN4Vh0L/MulQUNIw4JmT8M=;
        b=TQNFveG8foLY159y3U9W+sROMaLpHXeqQzOBrSg8SfA9Kf/Rqxd+1bEyZwz0HiKq9N
         jB5m922/LQoFyKpVDN9cPVLBRGUXU6gjSsDlDsDfdSNT1qbFEBkcPYIMbGZ4Zg7NTFoZ
         Rdf95eSM0pDBmyWrfsv/mSkbpvc46KyObLvZ179A6QsDy4SZDvmEf5qZvp8Oamn4Oxve
         JNquuyJe976fC6U/hHb124Ux9s/eRaO4aYE4SButXb6dvrTUc772sVMVYK8472jq72cN
         QRNCspXjJJZCcmeCMnfWfHH/PpGntKsD05/Ua0fo3dU9wpRa7UYpCcL3PC0/4nLfwmJ1
         3Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I2+6zjz21uipfp2QCPCdKXN4Vh0L/MulQUNIw4JmT8M=;
        b=dtu2b8eDhvjxrJezZnSfQUE206JGSBTmRfO1BOrcepmbwv7I7QTU3rbODxh3DUxGeq
         gkxyL0ALeyEvjyNgNBGGI4GM+AbVUdfoWFs98/OjapnpkGPEPKkcOnnHCd/n9NbeDTSh
         BKfcMbKsbxpmcFGnDNSZVvabui3oKjowlyca/k+4mj/Eeig7iIf++dGMeycgDCKcrSum
         TfttT72NzD32ro+ScZ55yePv3T9T+PnfYFs3+0oqndFoIR6XAaWI09MKj7yDSfssiGjx
         fAKsMy7EwICwuHsbabDnUP2cYa35cawo1L1cvINkXJ8jP4uAhKuhk6K8suJWRV1qY+a+
         pfsg==
X-Gm-Message-State: APf1xPDAkt0d9KtD7GRaqHMg0ClVHOoGu74Uj9iACDGLo+A7MCrMvsI+
        CJOp74KaUrdA5ikA/q+N2To4p2HX9d8/89nUlDY=
X-Google-Smtp-Source: AH8x226qV5fRtd455FwOg/z0yBvipNqd4AjMVRNMxLxGuNFSY6WnykNpi6Q04swqkJMmUcTv00iMLGCCyMECSYE6Hiw=
X-Received: by 10.55.39.88 with SMTP id n85mr16065048qkn.33.1518431312581;
 Mon, 12 Feb 2018 02:28:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.219 with HTTP; Mon, 12 Feb 2018 02:28:32 -0800 (PST)
In-Reply-To: <1518430656-21669-1-git-send-email-geert@linux-m68k.org>
References: <1518430656-21669-1-git-send-email-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Feb 2018 11:28:32 +0100
X-Google-Sender-Auth: AFSACDQWv1c8ykXuoGRhO-vXsFA
Message-ID: <CAMuHMdW5qRH93CMyRL-gbWgiA_rnizErbjNtSMT5b3d58N3ZTQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.16-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Rob Gardner <rob.gardner@oracle.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Mon, Feb 12, 2018 at 11:17 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.16-rc1[1] compared to v4.15[2].
>
> Summarized:
>   - build errors: +13/-5
>   - build warnings: +1653/-1537
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/head/7928b2cbe55b2a410a0f5c1f154610059c57b1b2/ (all 273 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/d8a5b80568a9cb66810e75b182018e9edb68e8ff/ (271 out of 273 configs)
>
>
> *** ERRORS ***
>
> 13 error regressions:
>   + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]:  => 1361:2

Lots of powerpc configs

>   + /home/kisskb/slave/src/drivers/net/ethernet/intel/i40e/i40e_ethtool.c: error: implicit declaration of function 'cmpxchg64' [-Werror=implicit-function-declaration]:  => 4443:6, 4443:2

mips{,el}-allmodconfig

>   + /home/kisskb/slave/src/fs/signalfd.c: error: 'BUS_MCEERR_AR' undeclared (first use in this function):  => 126:26

Lots of blackfin configs

>   + error: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!:  => N/A

sparc-allmodconfig (i.e. sparc32)

>   + error: No rule to make target arch/ia64/kernel/pci-swiotlb.o:  => N/A

ia64-defconfig (patch availavle)

>   + error: hotplug-cpu.c: undefined reference to `find_and_online_cpu_nid':  => .text+0x13c)

ppc64le/pseries_le_defconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
