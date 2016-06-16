Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 13:43:15 +0200 (CEST)
Received: from mout.gmx.net ([212.227.17.22]:58395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27041197AbcFPLnNvJrXb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jun 2016 13:43:13 +0200
Received: from [128.130.56.88] by 3capp-gmx-bs78.server.lan (via HTTP); Thu,
 16 Jun 2016 13:42:50 +0200
MIME-Version: 1.0
Message-ID: <trinity-17a92ddb-99fb-4084-bd99-4151434f09d4-1466077370809@3capp-gmx-bs78>
From:   p.wassi@gmx.at
To:     =?UTF-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "David Daney" <ddaney.cavm@gmail.com>,
        "David Daney" <david.daney@cavium.com>,
        =?UTF-8?Q?=22Michael_B=C3=BCsch=22?= <m@bues.ch>,
        "Hauke Mehrtens" <hauke@hauke-m.de>,
        "Larry Finger" <larry.finger@lwfinger.net>,
        "Felix Fietkau" <nbd@nbd.name>, "John Crispin" <john@phrozen.org>
Subject: Re: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 16 Jun 2016 13:42:50 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
References: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K0:teTBAoMdIum9j/gIErYpyxiJMT4G1KwV7fRjeWsgcoU
 jDkDwe4Cf7O37AQwaJnBm5scUFIHTBiApRuF4DWhc2XPUnlKD+
 Qi/wX9iM2nuX6mQjObnoMC8fUvHoK1vsnUyjUVnBkjFzKd+5As
 Ijw4n+IvWQuiwMwe5BoVLYQgTBGPPeGJfgZj2szjJen2AcSeEY
 YJHU+LbxVlNrBIi9+6HGlNXaOC3tP/rD7z72kKePnpGSPpew4L
 XQs7xcm7vuQuRf9RZdUnINuNUyXDaQqXQfgELYol6rtQc4EFxn Bzrtis=
X-UI-Out-Filterresults: notjunk:1;V01:K0:LFi+iCx5W3k=:acBpAyZbgI/AQjzyIIY+0Q
 0cwKmxdc9zO/79bPfpfnv0w0SNLOYOsvOh+8KoX1ulE9/GeO6vGtKd9nZZVJiAI+KZGenHTgN
 HIK2BBUCvzsj9UurbjxQgA2MjHId41jD4mhDr3VlRDKya3zNjTSPoMCbRC5mgUrx7ATISV1tW
 PHCbAFsXws/ENhvkJ3Jr6Z5/arH32JjTcVrKQfnT4OvQf+wnXBDilpaVKw3bMgfMcvtNqDYQx
 vfehgbZN5G2VjCc1IX4xGS5sP2f8eaG4pva9zJwykgYcyxs0OUTheqIbRRGP4yl+TqYwK609N
 VZstny1Ypff+Inz4F0OsUCOgwpk2or6hcUE9KCjvldNCRB/JtQczuw+6K13RCZB/0y2WmSZgX
 X7XDDoNM16HG8lhkUYfF1cRpgqn09Jg1TMov5UMfCJdufAvaVwCvNtfY/IVG6JTZoCleTWnTT
 jylZum/kRg==
Return-Path: <p.wassi@gmx.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.wassi@gmx.at
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

Hi Rafal,

> On the other hand Paul also experiences some problems with his Linksys
> WRT54GL (BCM5352E), the last stable kernel for him seems to be 3.18.

I have to calrify that a bit:
if I use prebuilt images from OpenWrt 15.05.1, they work out of the box (as you say, it's 3.18)
If I take prebuilt images from (LEDE|OpenWrt) trunk (which was 4.1 then), they do not boot.
However, if I clone the repo (which was used to build said trunk) and build it myself,
the images work fine. (kernel 4.1) [1]

The behaviour you described (stopping at "Starting program at 0x80001000") is the same
as I've observed it.

When I'm at home (weekend), I'll try if anything changed with 4.4

Just a side note: WRT54GL with 32MB RAM and LEDE work perfectly stable :-)

Best regards,
P. Wassi

[1]:
http://lists.infradead.org/pipermail/lede-dev/2016-June/001127.html
