Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g158QLR32019
	for linux-mips-outgoing; Tue, 5 Feb 2002 00:26:21 -0800
Received: from dea.linux-mips.net (a1as18-p231.stg.tli.de [195.252.193.231])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g158QHA32000
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 00:26:17 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g158Oag02647;
	Tue, 5 Feb 2002 09:24:36 +0100
Date: Tue, 5 Feb 2002 09:24:36 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wu Qingbo <wu_qingbo2000@yahoo.com.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: can mipsel linux support UDF?
Message-ID: <20020205092436.B2582@dea.linux-mips.net>
References: <200202050656.g156uxA19725@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202050656.g156uxA19725@oss.sgi.com>; from wu_qingbo2000@yahoo.com.cn on Tue, Feb 05, 2002 at 02:58:22PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 02:58:22PM +0800, Wu Qingbo wrote:

> I use mipsel-2.4.2 kernel and added udf into it. When the system is up,
> I mount -t udf /dev/cdrom /mnt. And it is ok, but sometimes will
> report {Drive Ready, Seek Complete}.
> But when I cd /mnt, and ls, I could not find anything. Sometimes the
> system is pause. My question is: Can mipsel linux support UDF?
> My DVD-ROM can work well use iso9660 format. If someone knows,

That still looks like some sort of hardware problem.  Maybe your DVD
disk has scratches or the drive is just broken enough no longer read
DVD's.  I have observed the same problem on non-MIPS systems.

  Ralf
