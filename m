Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2018 20:53:02 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991534AbeBFTwxkfhuO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Feb 2018 20:52:53 +0100
Date:   Tue, 6 Feb 2018 19:52:53 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        James Hogan <james.hogan@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: About Loongson platforms' directories
In-Reply-To: <CANc+2y4-Y9vb26K4Re8seR8vwrp4v2v8EzqsO9i-iZqWPuf41Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1802050406520.20018@eddie.linux-mips.org>
References: <1516182767.23672.1.camel@flygoat.com> <20180117132512.GG5027@jhogan-linux.mipstec.com> <2307410.P6mT3GKBU8@flygoat-x230> <CANc+2y4-Y9vb26K4Re8seR8vwrp4v2v8EzqsO9i-iZqWPuf41Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 17 Jan 2018, PrasannaKumar Muralidharan wrote:

> > Yes I would like to do so. Loongson-2K have a limited support with DeviceTree
> > (OpenFirmware) by U-Boot bootloader. Later SoC chips will also support DT as I
> > know.
> > But Loongson-1 series and 2E/2F only have leagcy boot support, no EFI, no DT,
> > even not all bootloader support machtype (in boot cmdline). That's why we want
> > to creat different entries for these platforms.
> 
> It is possible to use DT even if boot loader does not supply it. The
> dtb can be append to the kernel and kernel can be configured to pick
> it up.

 Problems start when such DTB disagrees with how the system has actually 
been configured.

 I once had to go through pains in the past when upgrading the kernel on a 
Freescale board where different versions of the firmware set up resources 
differently and the DTS supplied with the kernel assumed the most recent 
one.  I had to port random DTS updates to the old version to keep the old 
resource assignment while making the result understandable to the new 
kernel as the syntax evolved.  And I think I may not have got everything 
right as e.g. I couldn't access the PATA CD-ROM the system was equipped 
with after the upgrade anymore (fortunately I didn't need it, so I just 
ignored the problem).

 In case someone suggests I could have upgraded the firmware: well,
technically yes, but first that would cut the route back to the previous 
kernel version if the new one wasn't usable enough, and second the board 
was somewhere in a rack in a data centre across the pond, so no, I didn't 
dare bricking it.

 So yes, having a DTB integrated with the kernel is certainly an option, 
but a lot of care has to be taken to make it an aid rather than a burden.

 FWIW,

  Maciej
