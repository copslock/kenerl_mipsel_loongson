Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 20:51:22 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.15]:52412 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011825AbcBOTvTkav32 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2016 20:51:19 +0100
Received: from [192.168.123.49] ([37.24.8.189]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MRoyH-1aP6jV29Q9-00T0Pv; Mon, 15 Feb 2016 20:50:52
 +0100
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
 <56C1B3A0.4090301@cogentembedded.com> <56C21054.4070702@gmx.de>
 <20160215183838.GD1640@darkstar.musicnaut.iki.fi> <56C2253D.50101@gmx.de>
 <20160215194056.GE1640@darkstar.musicnaut.iki.fi>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <56C22C18.5090608@gmx.de>
Date:   Mon, 15 Feb 2016 20:50:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160215194056.GE1640@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7+UgkDIapHVHldsGfoUfwPfY8g7y5HPSO4n5/geVZOcPre3jkGe
 ziEFX1bJalVL/NHLw1QFElCRREwLord58OAFunwMdlkUhdunu3DZ169ftvzla2mtzYNo05M
 CiyR/402um1rVvOE6S2WRjx9Vgw2hWePuT8glAepINpuG+e4arJCz4fzDhGD+b3uiWjTMae
 XwmKFRygp2o1eG3oOacTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pjxr0b6ZdP8=:VlJDfG2x/4IgTjhI8JN9Ij
 tC6LwqFfDrTQUNdh4PwzMImrUtFrh43mTtldpW3v0rJ7x77AbC1ScrzXPzrOmMl8kDsexM8sr
 3y4I58ey99TdvqGoHAx87GVKtKg1ja2PoLzT1nG7JqeCGjhrsRhW1e7k0UvZqghXeHEndREYz
 mo+uCSBAH7ColcGTNHl2xM+ZpnJFDzE6aqIIRc9qND1kgYjk/3VFSGtqjSu1VXyvcLNLv1HY+
 WOsprSJMK8sumtxU0EUomqU8b9Xjl2F1jTvCh64M5OX4kl3qQHUkdOB1V1VhSB+WCUCSSLT+V
 48HZeCOJrl5Tw4Yb0Q3y5/q9HMoa7nsQxF1kHOtrvUYbsg418DJGcpaFtS4NxxCZaxafbaOaX
 dJoKlUyMkQ6X1d+TWczL777MWbZNk/u2MvARc7bSlGVNGDX6RqqPzCi5K5z8InjSbnsRizuvO
 UXTrMVxlBKDjpygw8nmM5NAS7NvoOoVPjOOtfjnS6hs7NUjF8+Zc85+m3BxZuYC2W/yhUX1/q
 lv7SGH2vWGrMtnNlzSz5f7fYPEeFIOO+/KBgzAWz2f+V8s4fQWDLJh39zF2XYRteD1yxvBQVJ
 aj3F+qW4T6ofzbXUxl/v1NOIlUGo1c/IDcsBXFUkC3u+nESOOc0gi2aQeaMX9xKARJkPnv4va
 eF/iD7305FJRnRIonw2hnqgDFWJIyBUicmbcG7ZqXsiKV2DGKvCRkayAlmV6a6SyMwI4AgbVY
 Po3ePYLMVJB+X85H4IUWj7cxRlJ1QllkKXcOJ6kmHXf305hq5YxcD5j4AcoBmITeULHnhdRAK
 3DquMM5
Return-Path: <xypron.glpk@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xypron.glpk@gmx.de
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

On 02/15/2016 08:40 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Feb 15, 2016 at 08:21:33PM +0100, Heinrich Schuchardt wrote:
>> flash-kernel has a database /usr/share/flash-kernel/db/all.db with
>> entries like:
>>
>> Machine: LeMaker Banana Pi
>> Kernel-Flavors: armmp armmp-lpae
>> Boot-Script-Path: /boot/boot.scr
>> DTB-Id: sun7i-a20-bananapi.dtb
>> U-Boot-Script-Name: bootscr.sunxi
>> Required-Packages: u-boot-tools
>>
>> Machine refers to the value of /proc/device-tree/model.
>> DTB-Id is the dtb to be installed.
>>
>> So what flash-kernel does is:
>> - look up value of /proc/device-tree/model
>> - retrieve correlated dtb file name from database
>> - install dtb with this name
>> - create symbolic links for the dtb
>>
>> If multiple boards use the the same dtb that is fine with flash-kernel
>> as long as the value of model is unique per dtb.
> 
> OCTEON does not work like this. The file you are modifying
> (octeon_3xxx.dts) is compiled into the kernel, and there is no external
> DTB file. So the model string will be always the same regardless on
> which board you have booted the kernel.
> 
> A.
>
Hello Aaro,

you are right DTBs are built in for MIPS systems.

Still it would be useful to be able to use the same property 'model' to
determine which u-boot script (boot.scr) to install.

Best regards

Heinrich Schuchardt
