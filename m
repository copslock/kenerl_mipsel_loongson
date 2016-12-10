Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Dec 2016 23:31:45 +0100 (CET)
Received: from mx.sealand.io ([193.160.39.68]:50117 "EHLO mx.sealand.io"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993164AbcLJWbhNFchc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Dec 2016 23:31:37 +0100
Received: by mx.sealand.io (Postfix, from userid 111)
        id 4D2C05601A0; Sat, 10 Dec 2016 23:14:55 +0100 (CET)
Received: from [IPv6:2003:48:a38:a100:5b5:d0fe:a2b0:6fab] (p200300480A38A10005B5D0FEA2B06FAB.dip0.t-ipconnect.de [IPv6:2003:48:a38:a100:5b5:d0fe:a2b0:6fab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.sealand.io (Postfix) with ESMTPSA id 3A1E15600A1;
        Sat, 10 Dec 2016 23:14:53 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
From:   =?utf-8?Q?Dan_L=C3=BCdtke?= <mail@danrl.com>
In-Reply-To: <87vauvhwdu.fsf@alice.fifthhorseman.net>
Date:   Sat, 10 Dec 2016 23:18:14 +0100
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Netdev <netdev@vger.kernel.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <CE942916-BF45-44CC-A5F5-3838CF9C93BC@danrl.com>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
 <87vauvhwdu.fsf@alice.fifthhorseman.net>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
X-Mailer: Apple Mail (2.3251)
Return-Path: <mail@danrl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mail@danrl.com
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


> On 8 Dec 2016, at 05:34, Daniel Kahn Gillmor <dkg@fifthhorseman.net> wrote:
> 
> On Wed 2016-12-07 19:30:34 -0500, Hannes Frederic Sowa wrote:
>> Your custom protocol should be designed in a way you get an aligned ip
>> header. Most protocols of the IETF follow this mantra and it is always
>> possible to e.g. pad options so you end up on aligned boundaries for the
>> next header.
> 
> fwiw, i'm not convinced that "most protocols of the IETF follow this
> mantra".  we've had multiple discussions in different protocol groups
> about shaving or bloating by a few bytes here or there in different
> protocols, and i don't think anyone has brought up memory alignment as
> an argument in any of the discussions i've followed.
> 

If the trade-off is between 1 padding byte and 2 byte alignment versus 3 padding bytes and 4 byte alignment I would definitely opt for 3 padding bytes. I know how that waste feels like to a protocol designer, but I think it is worth it. Maybe the padding/reserved will be useful some day for an additional feature.

I remember alignment being discussed and taken very seriously in 6man a couple of times. Often, though, protocol designers did align without much discussion. Implementing unaligned protocols is a pain I've experienced first hand.
From gregkh@linuxfoundation.org Sun Dec 11 08:15:01 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 08:15:09 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbcLKHPBQfJIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Dec 2016 08:15:01 +0100
Received: from localhost (smbcdgpass.hotspot.hub-one.net [213.174.99.145])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DEE7E5AA;
        Sun, 11 Dec 2016 07:14:53 +0000 (UTC)
Date:   Sun, 11 Dec 2016 08:15:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan =?iso-8859-1?Q?L=FCdtke?= <mail@danrl.com>
Cc:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>,
        linux-mips@linux-mips.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
Message-ID: <20161211071501.GA32621@kroah.com>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
 <87vauvhwdu.fsf@alice.fifthhorseman.net>
 <CE942916-BF45-44CC-A5F5-3838CF9C93BC@danrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CE942916-BF45-44CC-A5F5-3838CF9C93BC@danrl.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Sat, Dec 10, 2016 at 11:18:14PM +0100, Dan Lüdtke wrote:
> 
> > On 8 Dec 2016, at 05:34, Daniel Kahn Gillmor <dkg@fifthhorseman.net> wrote:
> > 
> > On Wed 2016-12-07 19:30:34 -0500, Hannes Frederic Sowa wrote:
> >> Your custom protocol should be designed in a way you get an aligned ip
> >> header. Most protocols of the IETF follow this mantra and it is always
> >> possible to e.g. pad options so you end up on aligned boundaries for the
> >> next header.
> > 
> > fwiw, i'm not convinced that "most protocols of the IETF follow this
> > mantra".  we've had multiple discussions in different protocol groups
> > about shaving or bloating by a few bytes here or there in different
> > protocols, and i don't think anyone has brought up memory alignment as
> > an argument in any of the discussions i've followed.
> > 
> 
> If the trade-off is between 1 padding byte and 2 byte alignment versus
> 3 padding bytes and 4 byte alignment I would definitely opt for 3
> padding bytes. I know how that waste feels like to a protocol
> designer, but I think it is worth it. Maybe the padding/reserved will
> be useful some day for an additional feature.

Note, if you do do this (hint, I think it is a good idea), require that
these reserved/pad fields always set to 0 for now, so that no one puts
garbage in them and then if you later want to use them, it will be a
mess.

thanks,

greg k-h
