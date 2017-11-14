Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 22:13:33 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:49549 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdKNVN0XKICl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 22:13:26 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 21:12:40 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 14 Nov
 2017 13:11:14 -0800
Date:   Tue, 14 Nov 2017 21:11:13 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Dave Taht <dave.taht@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [net-next,1/3] netem: convert to qdisc_watchdog_schedule_ns
Message-ID: <20171114211112.GA28794@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <1510088376-5527-2-git-send-email-dave.taht@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510693959-637140-28699-290898-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186930
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 FAKE_REPLY_C           META:  
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=FAKE_REPLY_C, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Nov 07, 2017 at 12:59:34PM -0800, Dave Taht wrote:
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index db0228a..443a75d 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c

...

> @@ -305,11 +305,11 @@ static bool loss_event(struct netem_sched_data *q)
>   * std deviation sigma.  Uses table lookup to approximate the desired
>   * distribution, and a uniformly-distributed pseudo-random source.
>   */
> -static psched_tdiff_t tabledist(psched_tdiff_t mu, psched_tdiff_t sigma,
> -				struct crndstate *state,
> -				const struct disttable *dist)
> +static s64 tabledist(s64 mu, s64 sigma,

sigma is used in a modulo operation in this function, which results in
this error on a bunch of MIPS configs once it is made 64-bits wide:

net/sched/sch_netem.o In function `tabledist':
net/sched/sch_netem.c:330: undefined reference to `__moddi3'

Should that code not be using <linux/math64.h>, i.e. div_s64_rem() now
that it is 64bit?

Thanks
James

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloLW/AACgkQbAtpk944
dnpWmA//aZDkO1jeDKifUd/Xv5uxz34KRv/ZiFZu+Ac65gDU1pKDwepoMniKXXxE
CCnrrkP0q/iH8VrXy3dAld+rlqm/2byhvhhaBknKz/XN0lgnqK1VSPJANafIhNMf
vEgudbuel/Lw7MNV4gCHEhTlab/9GiE/2s/LKxkUSYXwbHue6y3tB/eHF+lRtQjg
05D4Gstbe/BPqVthe0ZpxVIJpeck2YAAQ6bXUHa6pJ9YAAATJJ7/XXBki07/CzAF
WXxft8TFaHNaT94YYh6iU90AddJtWCEAthCQr9BzghtOZjgfr/ErxS5PxT53I8qE
IMwkAU3dvMiRQv5Ceaq9vkyrWFhmoqNOhEeq4sRU6kniZXG4t7l/0AWq67szbxNy
XR1j/VPfq2+hTFMddV3t6fkHLVBFRZVQJ7ZUM89mjxwDTTtbi7lCaBnnf73SPOmd
uHwFd+HbwjcR3A7pBlSdygbLlxLdWhqp+JqGgc5bzDxtO4cgTGJ3RGrZbkd5DWHO
Y/6WT7vocGf91wOh6gakSjVj+66+L9WGwY2PqAnMjtX4BOv6QQciLhLTdWFdlkVz
D/nflDE06jAt1Nbc+n+uRm+l5aON1K31Su74UG9UiQHK4WrwHj7KXF629+eqfaa8
HI52QjZ97Pd2eFEoE2Ad1LUf4+bq6g4CECAe2bWj7fz+KtQG2JM=
=4891
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
