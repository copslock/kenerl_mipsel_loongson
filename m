Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 09:49:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42826 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990480AbeCWIttKfcWE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 09:49:49 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id w2N8nlNS492842;
        Fri, 23 Mar 2018 09:49:48 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id w2N8nlTV492841;
        Fri, 23 Mar 2018 09:49:47 +0100
Date:   Fri, 23 Mar 2018 09:49:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@linux-mips.org
Subject: Re: SSL certificate of linux-mips.org have been expired
Message-ID: <20180323084947.GA453759@linux-mips.org>
References: <1521729033.6120.6.camel@flygoat.com>
 <20180322192410.GI13126@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322192410.GI13126@saruman>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63164
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

On Thu, Mar 22, 2018 at 07:24:11PM +0000, James Hogan wrote:
> Date:   Thu, 22 Mar 2018 19:24:11 +0000
> From: James Hogan <jhogan@kernel.org>
> To: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
> Subject: Re: SSL certificate of linux-mips.org have been expired
> Content-Type: multipart/signed; micalg=pgp-sha256;
>         protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
> 
> On Thu, Mar 22, 2018 at 10:30:33PM +0800, Jiaxun Yang wrote:
> > Hi MIPS maintainers:
> > 
> > SSL certficete of linux-mips.org have been expired. Either wiki or
> > patchwork can't be reached for now. Please renew the certificate,
> > thanks.
> > 
> > Btw: Is Ralf still maintaining these servers? I havn't seen him for a
> > long time.
> 
> Yes, Ralf maintains the server. I mentioned it to him by email yesterday
> after he emailed me, so hopefully it'll be sorted soon.
> 
> Cheers
> James

Fixed now.  Renewal should be automated but somehow failed ...

  Ralf
