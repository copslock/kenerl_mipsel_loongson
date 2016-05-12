Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 22:52:06 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.74]:50630 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027122AbcELUwEpcC16 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 22:52:04 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MUo3w-1b6MQ604E8-00YD1A; Thu, 12 May
 2016 22:51:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Thu, 12 May 2016 22:50:54 +0200
Message-ID: <5000683.B2NcB5DoK5@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <50455529.fZie4vOnRh@debian64>
References: <4231696.iL6nGs74X8@debian64> <5734CE1C.8070208@synopsys.com> <50455529.fZie4vOnRh@debian64>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:vntcAMaoQG24CwAJrb74q2/cVrJTwp22FWkUnzLUYuNkxBoqp51
 14EmsKtsxOTIGQfDeOuhk9V2+LL+E8lEveesvuX7TzkrT5PJS63iY6tWrj2B/I6qB3k//A3
 zGE9dYIXf0HIqLYpEyy0apuQvn9zg+WXbsU0Ok0xNCqDJXwmmzeD02muBrE9+kAA6ToFryI
 OhKzSb01OLs97ebuxO9qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zS8H0IDSNoY=:2oiDkSmXDmIga8vz0l+Ipg
 zgCmeOgpylhhZ/QIpY7K59fsb2s6BZlG/QlsuyD0LeTQOLN1pKlT28l1+UsqLYGEgbmc1CY9I
 w8YHUmZn9UhegQ2L6CDnyvvzcncODhXxP7RlbOkEVaGsiBBmwxRVmeQF/+Kf9MISVhv7m9yMY
 2RDLfBEK2NJZl9FrT56stb0TnIxESTg19ONjlGKdIjnztjUpRWIkoCef972bP59NGeO4OM9AQ
 eMIqplEkxBdn1xGuv1vtu5Jil44gzM89VqrfenRVOneNQajuIRivxcZGW+bcpbwzIpL5/UmZB
 ewpiA9IN0ilRa6C/WhXqBc14JQEG8s8JVC8kTD3WgUekkkCyIaDdqLUBjlyitnIsDqv/gqzaY
 jtXEtpZ9ufXt2ZoCHKWaBRaYl27uaOVMgB4NMib9S9b/+Wo7H8l18T4Qxl0DWmrFAHOye4tsK
 WDmcfQO5oIVQP+Hh0t6eqM/I8vhSAYamIeltT1rDmTFt55b/PMBuUZXnpkVIyRm8ClTupIo+Z
 HqpnRRuDhCIZFqVcCuhuIVjeqlgU1Ex9GxzxzhTnQumhYXYuQB62uxEG3Q5/8XhCE0BX+rxz6
 Hx1HPY/uap1yfdGrSMUxUuxwWXSKXDgysMTLaMPLW1jZaO8Szmw8vgJ611A+w0VEZhUA21g1J
 KJ4CgL9KeDp5JpbYGPp1RlXHwyGIE2UqxnbJjIoFLKJzrLIkwfOlqdTFzVgLpQB349blKdL5h
 dpIJqfQabcW2kJNy
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 12 May 2016 22:39:36 Christian Lamparter wrote:
> On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
> > On 5/12/2016 6:30 AM, Christian Lamparter wrote:
> > > On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> > >>
> > >> If I recall correctly, the rough consensus was to go with your longer
> > >> patch in the future (fixed up for the comments that BenH and
> > >> I sent), and I'd suggest basing it on top of a fixed version of
> > >> my patch.
> > > Well, but it comes with the "overhead"! So this was just as I said:
> > > "Let's look at it and see if it's any good"... And I think it isn't
> > > since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
> > > archs etc...
> > 
> > I slightly prefer the more general patch for future kernel versions.
> > The overhead will probably be negligible, but we can perform some
> > testing to make sure.
> > 
> > Can you resubmit with all gathered feedback?
> Yes I think I can do that. But I would really like to get the
> regression out of the way. So for that: I back Arnd's patch.
> It explains the problem much better and doesn't kill MIPS 
> like the revert I was doing in my initial post to the MLs.
> Also, another bonus: his patch is suited to port to stable.
> 
> The auto-detection approach is not that easy to get right,
> given all the stuff that's going on with BE8, LE4, ... So
> can we have your "blessing" for Arnd's patch for now? since
> that way, I can base my patch on top of his work about the
> issues of endiannes? (Just say: ACK  )
> 
> Arnd: do you have a version with the #ifdef lower/uppercase
> fix? Or should I give it a try (and fail in a different way  )

I've already fixed it up locally, will send the latest version
so it's out there, whether Felipe takes it or not.

	Arnd
