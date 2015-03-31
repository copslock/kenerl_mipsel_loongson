Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 14:56:34 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:53122 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010408AbbCaM4d0P0Z5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 14:56:33 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id t2VCuQjP020384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 31 Mar 2015 12:56:26 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id t2VCuOdN013108;
        Tue, 31 Mar 2015 14:56:24 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 15:56:15 +0300
Date:   Tue, 31 Mar 2015 15:56:14 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: malta: pass fw arguments on kexec
Message-ID: <20150331125614.GN24448@ak-desktop.emea.nsn-net.net>
References: <1424877665-4487-1-git-send-email-aaro.koskinen@nokia.com>
 <20150331111300.GB28951@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150331111300.GB28951@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 790
X-purgate-ID: 151667::1427806586-00005972-F158CAAB/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Hi,

On Tue, Mar 31, 2015 at 01:13:00PM +0200, Ralf Baechle wrote:
> On Wed, Feb 25, 2015 at 05:21:05PM +0200, Aaro Koskinen wrote:
> >  #define SOFTRES_REG	0x1f000500
> > @@ -36,8 +38,19 @@ static void mips_machine_power_off(void)
> >  	mips_machine_restart(NULL);
> >  }
> >  
> > +static int mips_kexec_prepare(struct kimage *image)
> > +{
> > +	kexec_args[0] = fw_arg0;
> > +	kexec_args[1] = fw_arg1;
> > +	kexec_args[2] = fw_arg2;
> > +	kexec_args[3] = fw_arg3;
> > +
> > +	return 0;
> > +}
> 
> This makes arguments coming from the firmware non-overridable default?

Yes, the new kernel will boot with the same arguments as the old kernel...

I guess the kernel command line at least should be taken from kexec,
OCTEON seems to have some code for that.

A.
