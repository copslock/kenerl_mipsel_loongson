Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 20:01:20 +0100 (BST)
Received: from xproxy.gmail.com ([66.249.82.194]:57398 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465726AbVJTTBE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 20:01:04 +0100
Received: by xproxy.gmail.com with SMTP id h31so293455wxd
        for <linux-mips@linux-mips.org>; Thu, 20 Oct 2005 12:01:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQjkUR1C8CIuRGHSwxxNmsmjE+p/vruO5Ccdo8UQMj2+olrADALRUOP4usbfq1Mg9AlRAEAIwAEALorA7TinyvbYMXKH2O56nZklECwzvGUFzhhdpVRppUlec6A+AqpYaY2bX+cWmoqfQAjqSBlkzj9AjZnbOojfhXuB+/idsSc=
Received: by 10.70.102.12 with SMTP id z12mr1173459wxb;
        Thu, 20 Oct 2005 12:01:01 -0700 (PDT)
Received: by 10.70.105.6 with HTTP; Thu, 20 Oct 2005 12:01:01 -0700 (PDT)
Message-ID: <4807377b0510201201i685efd46qf4c548da34b996cb@mail.gmail.com>
Date:	Thu, 20 Oct 2005 12:01:01 -0700
From:	Jesse Brandeburg <jesse.brandeburg@gmail.com>
To:	ddaney@avtrex.com
Subject: Re: Patch: ATI Xilleon port 2/11 net/e100 Memory barriers and write flushing
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
Return-Path: <jesse.brandeburg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesse.brandeburg@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/19/05, David Daney <ddaney@avtrex.com> wrote:
> @@ -584,6 +584,7 @@ static inline void e100_write_flush(stru
>  {
>         /* Flush previous PCI writes through intermediate bridges
>          * by doing a benign read */
> +       wmb();
>         (void)readb(&nic->csr->scb.status);
>  }

I find it odd that this is needed, the readb is meant to flush all
posted writes on the pci bus, if your bus is conforming to pci
specifications, this must succeed.  wmb is for host side (processor
memory) writes to complete, and since we're usually only try to force
a writeX command to execute immediately with the readb (otherwise lazy
writes work okay) we shouldn't need a wmb *here*.  not to say it might
not be missing somewhere else.


> @@ -807,9 +808,13 @@ static inline int e100_exec_cmd(struct n
>                 goto err_unlock;
>         }
>
> -       if(unlikely(cmd != cuc_resume))
> +       wmb();
> +       if(unlikely(cmd != cuc_resume)) {
>                 writel(dma_addr, &nic->csr->scb.gen_ptr);
> +               e100_write_flush(nic);
> +       }
>         writeb(cmd, &nic->csr->scb.cmd_lo);
> +       e100_write_flush(nic);

wouldn't the last e100_write_flush be all that is needed?  e100 only
needs them to come in order, they don't need to be flushed one at a
time.

I can see how this change might be needed in a true write posting environment.

jesse
