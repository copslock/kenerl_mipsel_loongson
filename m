Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 01:33:26 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.186]:8534 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039028AbXBBBdW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 01:33:22 +0000
Received: by nf-out-0910.google.com with SMTP id l24so998822nfc
        for <linux-mips@linux-mips.org>; Thu, 01 Feb 2007 17:32:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ot/hPfPPYQrptRtbXLkclKfE2v93KX+NR6VspjtnZjdp5FK57Wl3UtuSvuhOMxSQBupxEAwEcn+2rtiDShTOvKnNQGoZv+zChUjpThjhcrQKrupVyU2R2ZYiS0LkliLpHtIZmwv5mUlW8bYHEPc02VqEQk8U5ANGvcjCrfNfFPU=
Received: by 10.49.13.19 with SMTP id q19mr5644616nfi.1170379941865;
        Thu, 01 Feb 2007 17:32:21 -0800 (PST)
Received: by 10.49.66.16 with HTTP; Thu, 1 Feb 2007 17:32:21 -0800 (PST)
Message-ID: <816d36d30702011732p60b73fe8w1c7a14ee07a3a748@mail.gmail.com>
Date:	Thu, 1 Feb 2007 21:32:21 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Wim Vander Schelden" <wim.vanderschelden@gmail.com>
Subject: Re: Linux on the MobilePro 7xx
Cc:	linux-mips@linux-mips.org
In-Reply-To: <45C289C9.3010409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45C289C9.3010409@gmail.com>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/1/07, Wim Vander Schelden <wim.vanderschelden@gmail.com> wrote:
> Hi,
>
> I just purchased a MobilePro 770 and I intend to port linux to it. It
> runs on a VR4121 CPU, is there already some support in linux-mips for that?
>
> I found some stuff on the net, but it all uses 2.4 kernels, and I would
> rather get a 2.6 going.
>
> Anyone who knows a little bit more about the subject is welcome to comment,
>
> Wim

Hi Wim,

The VR41XX branch is pretty much fully supported in the kernel, thanks
to Yoichi Yuasa's work. You just need to make some board setup code
for the MP and you should be ready to boot a kernel on it.

On the current linux-mips tree there is NO support for neither fb,
pcmcia, touchscreen or keyboard for the MP; there are, however, some
drivers for fb, tpanel and keyb written somewhere, just look for them.

PCMCIA is broken due to i82365 legacy way of sorting irq's. Taking a
look at old linux-vr code for 2.4 tree might help to give you an idea
on whats causing the problem.


     Ricardo
