Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QESYK15717
	for linux-mips-outgoing; Fri, 26 Oct 2001 07:28:34 -0700
Received: from hell.ascs.muni.cz (hell.ascs.muni.cz [147.251.60.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QESR015706;
	Fri, 26 Oct 2001 07:28:28 -0700
Received: (from xhejtman@localhost)
	by hell.ascs.muni.cz (8.11.6/8.11.6) id f9QEVHg23815;
	Fri, 26 Oct 2001 16:31:17 +0200
Date: Fri, 26 Oct 2001 16:31:17 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Origin 200
Message-ID: <20011026163117.B27258@mail.muni.cz>
References: <20011025010425.C2045@mail.muni.cz> <Pine.LNX.4.21.0110242021240.25602-100000@ns> <20011025103333.E2045@mail.muni.cz> <20011025121450.A1644@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011025121450.A1644@dea.linux-mips.net>; from ralf@oss.sgi.com on Thu, Oct 25, 2001 at 12:14:50PM +0200
X-MIME-Autoconverted: from 8bit to quoted-printable by hell.ascs.muni.cz id f9QEVHg23815
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f9QEST015707
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 25, 2001 at 12:14:50PM +0200, Ralf Baechle wrote:
> Btw, Origin UP kernel is definately broken ...

I think I've tracked down what makes freeze. If I use default config but
network card driver and scsi driver (seems to be generic PCI device) kernel
boots up to message I have no root (any time and not freezes I've changed little
bit sources to print '... waiting ...' every 2 seconds in infinite loop before
it does panic -- no root).

So I think there is some deadlock after some PCI device driver init that does
not occur in SMP mode.

-- 
Luká¹ Hejtmánek
