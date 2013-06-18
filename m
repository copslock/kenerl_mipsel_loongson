Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 23:28:46 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51379 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827443Ab3FRV2oVB9y1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 23:28:44 +0200
Received: by mail-wi0-f177.google.com with SMTP id ey16so396wid.10
        for <linux-mips@linux-mips.org>; Tue, 18 Jun 2013 14:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=/8GcsYLbt9fd6W0mszMW2hMiyOSbJO3EQTYLzEZPIMI=;
        b=CLy1FamF86FZqFloPy9qbw/HvqLEv2xeQ2x6cvmQZQRxhFXNLkbF6EyI7Mp+iXgoGc
         MZe3bLHWeCdbSK/0nf7hrhD9Y0+S+fnoJHRw0D4KGbCOpEe46B8Q+XxdO7/DErwvjKjd
         pz1SybdRbx9qT455zVuucvE8K7TSAWgHa55wzlOiiW1tHi3bgxK9enry+G5SKnlZ8Hsd
         u7QXuea4Ksefxy8Yzfbxa5YWxPZ7hjAOK/9ijq+gGs2alMcIFm6JGiIg9TLFurY/AHwk
         OLPnpEqZEWRmo4jhCdOkwTLXiGSeG0pkHSVJXkKW8Op9+YTTNUUW1gojNF4T6hsbHJo0
         tt4A==
X-Received: by 10.180.206.109 with SMTP id ln13mr4109936wic.20.1371590918823;
        Tue, 18 Jun 2013 14:28:38 -0700 (PDT)
Received: from localhost ([2.216.16.214])
        by mx.google.com with ESMTPSA id ev19sm4987308wid.2.2013.06.18.14.28.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 14:28:37 -0700 (PDT)
Date:   Tue, 18 Jun 2013 22:28:36 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Message-ID: <20130618212836.GB3440@maple>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQldA4odbU9piss3Qf9baX+Hw3mMtw9P3I7G43n6KOQl/d/wH+0nlPzS5MnSqSlcHW+IEGqU
Return-Path: <jamie@jamieiles.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
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

On Tue, Jun 18, 2013 at 12:12:50PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Get rid of the custom OCTEON UART probe code and use 8250_dw instead.
> 
> The first patch just gets rid of Ralf's Kconfig workarounds for the
> real problem, which is OCTEON's inclomplete serial support.
> 
> Then we just make minor patches to 8250_dw, and rip out all this
> OCTEON code.
> 
> Since the patches are all interdependent, we might want to merge them
> via a single tree (perhaps Ralf's MIPS tree).

Looks good!

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

for the series.

Thanks,

Jamie
