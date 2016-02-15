Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 20:22:07 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.15]:50327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012547AbcBOTWCPtxWQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2016 20:22:02 +0100
Received: from [192.168.123.49] ([37.24.8.189]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MQ33z-1aZXaE0K7H-005Ehc; Mon, 15 Feb 2016 20:21:37
 +0100
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
 <56C1B3A0.4090301@cogentembedded.com> <56C21054.4070702@gmx.de>
 <20160215183838.GD1640@darkstar.musicnaut.iki.fi>
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
X-Enigmail-Draft-Status: N1110
Message-ID: <56C2253D.50101@gmx.de>
Date:   Mon, 15 Feb 2016 20:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160215183838.GD1640@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KhCjQ230bQ8nmHaV2IxTwS6ZFH6alOXH2MGDkN7LJ2A/C/vW/yy
 +ueSZqK8Nq5ikkVWQFXui/IpuPGK4Krg6Sy7WoIN5WLnd8TXEmpdQYfa06gOKm5brqWpIq9
 QYVLkeOTO9hp6mCd8h5626FTWzBwLbXAzralZE29mTXlh/jMHuVOfZjhw6W1Vox07SiiU2X
 slXtFF6W6gvr3T1hgdVIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ETXZLB2HtTo=:r1SKQIk9IGyDQ/JF/Fmla5
 MYCZyUPabH15sZd0dbo4650/qj1wg5vuKFszUKTRwrguTXVBuu1KSgoaANYqVEYlRCjuRX3IX
 Jw+gm+IkU7e6TQdi3cgtowoLZ3+MaKxAYir9iUlA+hI0pJyBukGShT3O8i+7zjLC5u2IM3bGS
 3PhxWgK97B//3k/7fXqJEQ6Ir1XUzJSU9wK1WX+kqM6WXFoBTFMu+bhe50Dh9Hv70MpnLaQ7P
 sKgyDZm95WaQN6EaEm4Iw3JslGiNtHYK98E20U7ZB+mFdAW6AksIo1sJ1EJYmsA5DfOsJhFTT
 qt9Lib31gmfWDEU3vuxEnNRtWZLYPaSxFZwASR1IQ2M0eU7/mOosIqvw8o5uUZCVmXQ8Q/2bG
 z/ZAUL5eEP3EiZt5+0WrGuNEJaxs4PBwwhUwdVbs4ULIDZMVZUZim29n25HML1sigfASLaj8A
 7slBi0r22PAT6IBjsucWKHxtVvbiuyV03IJh2HN0CcxBnnK/HsNq/LTJRJfrVi/4+wLIhxSH5
 5ZBAIUyy4EVBWBNNB08T2oN5R47x81WONviEpKptSF8F+9Lsd0xapCtDc8hP2Se/K6qw/uuSj
 ILbErB3qQExsXMy+wJOKT/DNobXGbqbBlR0RwWajO7uYmU7Vl6jtPmo67PK7wYHpDqt7MQ9xZ
 zQO8nbXAHSn8u5lXgAah1ESY2NH0Slcql+r6jvXcpxv0POONRAKbDZp7gkXd9JR1EmAVdexZ1
 vNx1bgpgAxf6h8HRcCL+CTC9DisA3y/A/qSTorFdy1D0szNriCfY+XEwIIx2wMmv0f9m0ZT89
 lQHq36N
Return-Path: <xypron.glpk@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52071
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

On 02/15/2016 07:38 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Feb 15, 2016 at 06:52:20PM +0100, Heinrich Schuchardt wrote:
>> On 02/15/2016 12:16 PM, Sergei Shtylyov wrote:
>>> On 2/15/2016 8:26 AM, Heinrich Schuchardt wrote:
>>>> Downstream packages like Debian flash-kernel rely on
>>>> /proc/device-tree/model
>>>> to determine how to install an updated kernel image.
>>
>> Would you support a patch having the following strings?
>>
>> model = "CAVM, Octeon 3860";
>> model = "CAVM, Octeon 6880";
> 
> The built-in DTBs are shared by multiple completely different boards
> (from multiple different manufacturers). How would those strings help
> for cases like flash-kernel?
> 
> A.
> 
Hello Aaro,

flash-kernel has a database /usr/share/flash-kernel/db/all.db with
entries like:

Machine: LeMaker Banana Pi
Kernel-Flavors: armmp armmp-lpae
Boot-Script-Path: /boot/boot.scr
DTB-Id: sun7i-a20-bananapi.dtb
U-Boot-Script-Name: bootscr.sunxi
Required-Packages: u-boot-tools

Machine refers to the value of /proc/device-tree/model.
DTB-Id is the dtb to be installed.

So what flash-kernel does is:
- look up value of /proc/device-tree/model
- retrieve correlated dtb file name from database
- install dtb with this name
- create symbolic links for the dtb

If multiple boards use the the same dtb that is fine with flash-kernel
as long as the value of model is unique per dtb.

Best regards

Heinrich Schuchardt
