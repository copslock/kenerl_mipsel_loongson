Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 22:27:02 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:52684 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeDKU0xzCJ0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2018 22:26:53 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 11 Apr 2018 20:26:21 +0000
Received: from localhost (192.168.154.110) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 11
 Apr 2018 13:26:36 -0700
Date:   Wed, 11 Apr 2018 21:26:17 +0100
From:   James Hogan <james.hogan@mips.com>
To:     Sinan Kaya <okaya@codeaurora.org>
CC:     <linux-mips@linux-mips.org>, <arnd@arndb.de>,
        <timur@codeaurora.org>, <sulrich@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Message-ID: <20180411202616.GA14760@jhogan-linux.mipstec.com>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
 <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
 <14a663f6-2ea5-230b-2cd0-e42d05d0d7ea@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <14a663f6-2ea5-230b-2cd0-e42d05d0d7ea@codeaurora.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1523478380-637138-31797-139092-1
X-BESS-VER: 2018.4-r1804052328
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191891
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63502
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

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 11, 2018 at 01:10:41PM -0400, Sinan Kaya wrote:
> How is the likelihood of getting this fixed on 4.17 kernel?

High.

Thanks
James

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrOb2IACgkQbAtpk944
dnpn5w/+NdCeCbGpfWtq/05XIQr+5dP9M4Ehvlt/vrkLEpfPvsEQZJUgGcq1Pxta
k6Tx18KiNbH+CE1bo4za6it0bgPtVrMgMLICCNxtXQWoI73SpzMSoG6PVR7iaWmw
vlN9WA8uI4isfvVxXNdm/vayR1XpRLcRtrJ/jiNIcDxi9q5nwUTtXHXB1nnP8rFq
m67popm0z1mTcSPxRdGLyWv+bpbeJdap2Sl7cdt+vtY66h0gG3Fgli5Ux7Mjc56t
+EFbUZWSgCmxD+0dZIzXErxAc7mduOH8YU6N87QJz9YPGRebvYYcLkgTGE3Lk4t7
G2D+63vWYRlB168NdaIt0PTO6bWoSkRsC2Wmo7JobhD4tWzJKFFUgX21dwL0CcWx
Xb1EQgOa6n/eBh5SQikV0SsVjELNvcIXIf+pKNgH++fN9zZ/JMSW7wAm9FEv/0kh
wImtrz7Gh5Cx7GD9HVBTEa55T32DNOWliGUQW/E4pSJVexIUuV+VzZFovQq92qrZ
PYfmw2VmEznT8qHQEr1BMCSGqQp6sDYBzCgpym9UxYLW5qw9mhY4MwMr8wckl5Lz
eMR7cMdE+1luEpJgx/F/mVjbXBQv2sy7/Bgsb+c/01O07/9R1vTbDPpUczL2E3Zs
jSkZns8v0IzTzJtp5tyJRTWUdsqb2UzC2vWbNvrDg5us3chy2+8=
=TNbG
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
