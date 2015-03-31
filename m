Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 16:19:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57633 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009525AbbCaOTGksnK4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 16:19:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VEJ70l025421;
        Tue, 31 Mar 2015 16:19:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VEJ6K8025420;
        Tue, 31 Mar 2015 16:19:06 +0200
Date:   Tue, 31 Mar 2015 16:19:06 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: malta: pass fw arguments on kexec
Message-ID: <20150331141906.GF28951@linux-mips.org>
References: <1424877665-4487-1-git-send-email-aaro.koskinen@nokia.com>
 <20150331111300.GB28951@linux-mips.org>
 <20150331125614.GN24448@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150331125614.GN24448@ak-desktop.emea.nsn-net.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Mar 31, 2015 at 03:56:14PM +0300, Aaro Koskinen wrote:

> On Tue, Mar 31, 2015 at 01:13:00PM +0200, Ralf Baechle wrote:
> > On Wed, Feb 25, 2015 at 05:21:05PM +0200, Aaro Koskinen wrote:
> > >  #define SOFTRES_REG	0x1f000500
> > > @@ -36,8 +38,19 @@ static void mips_machine_power_off(void)
> > >  	mips_machine_restart(NULL);
> > >  }
> > >  
> > > +static int mips_kexec_prepare(struct kimage *image)
> > > +{
> > > +	kexec_args[0] = fw_arg0;
> > > +	kexec_args[1] = fw_arg1;
> > > +	kexec_args[2] = fw_arg2;
> > > +	kexec_args[3] = fw_arg3;
> > > +
> > > +	return 0;
> > > +}
> > 
> > This makes arguments coming from the firmware non-overridable default?
> 
> Yes, the new kernel will boot with the same arguments as the old kernel...
> 
> I guess the kernel command line at least should be taken from kexec,
> OCTEON seems to have some code for that.

The old command line can be obtained from /proc/cmdline.  As per
documentation some boot formats but not all support the options
--command-line=string or --reuse-cmdline which I think is how it should
be done.

Sorry but cmdline manipulation in the kernel is just bad for my blood
pressure.  Among the issues:

Many MIPS platforms are manipulating the cmdline so what you eventually
find in /proc/cmdline may not what the firmware originally fed to the
kernel.  That's another tradition which should end - for sanity and
kexec's sake.

A few platfroms even hardcode the entire cmdline and that was done without
considering something like kexec.

And more.

  Ralf
