Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Apr 2009 19:07:28 +0100 (BST)
Received: from pyxis.i-cable.com ([203.83.115.105]:55777 "HELO
	pyxis.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20034724AbZDCSHV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Apr 2009 19:07:21 +0100
Received: (qmail 13795 invoked by uid 104); 3 Apr 2009 18:07:12 -0000
Received: from 203.83.114.122 by pyxis (envelope-from <robert.zhangle@gmail.com>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.201937 secs); 03 Apr 2009 18:07:12 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 3 Apr 2009 18:07:07 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n33I76lj005176;
	Sat, 4 Apr 2009 02:07:06 +0800 (CST)
Date:	Sat, 4 Apr 2009 02:06:53 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	wu zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] ftrace porting of linux-2.6.29 for mips
Message-ID: <20090403180652.GC27751@adriano.hkcable.com.hk>
Mail-Followup-To: wu zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <b00321320904021847w5ab3acb6nd1cd554c251ef8f6@mail.gmail.com> <20090403113315.GC6629@adriano.hkcable.com.hk> <b00321320904030503w8fe0165t2aded6727f35e24c@mail.gmail.com> <b00321320904030551p774d295lce3581c23d9d8c26@mail.gmail.com> <20090403141158.GA27751@adriano.hkcable.com.hk> <b00321320904030753s2e10503fud4ba50b0fda13d8f@mail.gmail.com> <20090403160304.GB27751@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090403160304.GB27751@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 00:03 Sat 04 Apr     , Zhang Le wrote:
> On 22:53 Fri 03 Apr     , wu zhangjin wrote:
> > On Fri, Apr 3, 2009 at 10:11 PM, Zhang Le <r0bertz@gentoo.org> wrote:
> > > On 20:51 Fri 03 Apr     , wu zhangjin wrote:
> > >> okay, please check the attachment, thx!
> > >>
> > >> including:
> > >>
> > >> 1. add the HAVE_FUNCTION_TRACE_MCOUNT_TEST line in arch/mips/Kconfig
> > >> 2. remove the useless registers save & restore operation in mcount.S
> > >> 3. and add a "notrace" flag to tick_do_update_jiffies64 to avoid the
> > >> nmi exception problem.
> > >
> > > Have you tested the latest patch? Any working .config file?
> > > I just tested it, seems can't boot.
> > 
> > yes, i have tested it on qemu/malta, the attachment include a
> > configuration & an init ram fs: initrd.gz
> > 
> > boot it:
> > 
> > $ qemu-system-mipsel -kernel vmlinux-qemu-malta-ftrace -initrd
> > qemu-malta-initrd.gz -append "root=/dev/ram0 init=/bin/sh
> > console=ttyS0 ramdisk_size=3000"  -nographic -M malta -hda /dev/zero
> > 
> > and also, i just test it on loongson2f(fuloong 6003) with the
> > configuration file: defconfig-fl-rt-ftrace, but configured only as
> > serial port debugging mode via a minicom, so, you need to add the
> > other kernel modules if not have a serial
> > port :-(
> 
> I will check whether there is any difference between the config caused the
> problem.

Still no luck. Maybe you are using a different loongson 2f patchset, not the
one in my git tree. I know lemote has a to-mips branch, maybe you are using that?
I tried to merged it with my tree yesterday, but haven't finished yet.

Anyway, would you please show me the whole source you are using?

Thanks!

Zhang, Le
http://zhangle.is-a-geek.org

> 
> At the meantime, would you please try my git tree, to see if it works?
> 
> Thanks!
> 
> Zhang, Le
> http://zhangle.is-a-geek.org
> 
> > 
> > >
> > > I have pushed the patch, along with my fix, to my git tree, so that
> > > the patch could be further polished. It is in linux-2.6.29-stable-ftrace branch.
> > >
> > > http://repo.or.cz/w/linux-2.6/linux-loongson.git
> > >
> > > BTW, it seems linux-mips@vger.kernel.org is not an alias of
> > > linux-mips@linux-mips.org, since I haven't seen our previous emails appear in
> > > linux-mips ML's archive. So I have added linux-mips@linux-mips.org to CC list.
> > >
> > 
> > ooh, it's my fault :-) linux-mips@linux-mips.org is the right one~~
> > 
> > > When this patch is more ready to be included, we'd better include LKML in CC
> > > list, too. Because there are more ftrace gurus which could give advices to this
> > > patch.
> > >
> > > Zhang, Le
> > > http://zhangle.is-a-geek.org
> > >
> > >>
> > 
> > -- 
> > Studying engineer. Wu Zhangjin
> > Lanzhou University      http://www.lzu.edu.cn
> > Distributed & Embedded System Lab      http://dslab.lzu.edu.cn
> > School of Information Science and Engeneering         http://xxxy.lzu.edu.cn
> > wuzhangjin@gmail.com         http://falcon.oss.lzu.edu.cn
> > Address:Tianshui South Road 222,Lanzhou,P.R.China    Zip Code:730000
> > Tel:+86-931-8912025
> 
> 
> 
> 
> 
> 
