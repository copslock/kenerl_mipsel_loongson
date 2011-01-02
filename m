Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 15:49:14 +0100 (CET)
Received: from netrider.rowland.org ([192.131.102.5]:42702 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491926Ab1ABOtL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 15:49:11 +0100
Received: (qmail 23228 invoked by uid 500); 2 Jan 2011 09:49:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jan 2011 09:49:01 -0500
Date:   Sun, 2 Jan 2011 09:49:01 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     loody <miloody@gmail.com>
cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: is there dummy r/w in mips kernel API
In-Reply-To: <AANLkTinBYUHdsaz40216BRadvU3mx2H5F4Hfp1J0NibB@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1101020948030.22996-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+4d39b18a@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips

On Sun, 2 Jan 2011, loody wrote:

> Dear all:
> I am trying porting usb on mips platform.
> Due to hw limitation, I have to do the dummy read to make sure data
> has been written to the memory, so I announce an volatile parameter,
> tmp, such that cpu will read the same address back to me.
> 
> Below is what I try to do in usb driver:
>                         wmb ();
>     389c:       0000000f        sync
>                         dummy->hw_token = token;
>     38a0:       ae740008        sw      s4,8(s3)
>                         tmp = dummy->hw_token;
>     38a4:       afb40010        sw      s4,16(sp)
> as you can see, the compiler is so smart that he read the register
> content instead of re-read the memory for accelerating the read speed.
> unfortunately, that isn't I want. Is there already exist kernel API can help me?
> appreciate your help,

You can try doing:

		tmp = ACCESS_ONCE(dummy->hw_token);

Alan Stern
