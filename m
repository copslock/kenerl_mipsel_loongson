Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 13:51:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48762 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991955AbdCPMu5XaEX- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 13:50:57 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 99D1F41F8EC8;
        Thu, 16 Mar 2017 13:56:10 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 16 Mar 2017 13:56:10 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 16 Mar 2017 13:56:10 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EEE93E107962F;
        Thu, 16 Mar 2017 12:50:48 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 16 Mar
 2017 12:50:51 +0000
Date:   Thu, 16 Mar 2017 12:50:51 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@01.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 25/33] KVM: MIPS: Add VZ support to build system
Message-ID: <20170316125051.GD996@jhogan-linux.le.imgtec.org>
References: <2fd6fb9c03bac22f06697e07e794071bf18b7c83.1489485940.git-series.james.hogan@imgtec.com>
 <201703161904.ueBudWmA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lUWNHpMBvmChTRKs"
Content-Disposition: inline
In-Reply-To: <201703161904.ueBudWmA%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--lUWNHpMBvmChTRKs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 07:40:44PM +0800, kbuild test robot wrote:
> [auto build test WARNING on kvm/linux-next]
> [also build test WARNING on v4.11-rc2 next-20170310]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/James-Hogan/KVM-MIPS-Add=
-VZ-support/20170316-161027
> base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dmips=20
>=20
> All warnings (new ones prefixed by >>):
>=20
> warning: (REMOTEPROC && RPMSG_VIRTIO) selects VIRTUALIZATION which has un=
met direct dependencies (HAVE_KVM)

Yes, the new "depends on HAVE_KVM" is unnecessary anyway so I'll just
drop that.

Thanks!
James

--lUWNHpMBvmChTRKs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYyookAAoJEGwLaZPeOHZ6IwkQAL+CzMeara1Sg2c71babol/w
Yh460qBsuQLBaLqJ61+6nPWMbaoY2tYZTGXde/uKizKUyCqfB6caZcdmnG41VkKK
fMnqFvQM6c411OdlbZhS7EYrPsqwO+ZZfLDrAMEfK0uDw/fzvHzOGaVwO/I/JE5K
CddhPLqtgc8sEMhqr1m1en9EmPtpcgbcypmDbs6Edri0NnU+NbtsjKyBWZSR7wq7
dQ6gVxwgIH+0dNwdWnqXL0935Mqbx52ZRhd+7FNlCZeKF9iagbl8grBmqZBemuG5
pSgr5UZLEDKI2KlWwr8V6zZI1XwkU//jqHqQ4epPpo/KBlgbuQbL3IC+XokMHLe4
QXKYeZVGHaKgrvlPb+7VJKWtUGYc1jhtUqforo0mqkqwu1LCDyQEkRpdeLx9fgXI
BWQjtWum2qsuhAuCDwIUw3qjqOS1MxOezA7ij2lFslOYe6/pYkevcBWc1qlnHWIy
UTRDmlcqoefE+7WaM4Qk2E+XD9YYhYHV+pdaTd5yreceNGGcEa/I8YBZwvrd/6Gh
e8WDcNZfqmwSHkbcI6p8icX//DjZL56097mO9ZHG5jFrn6IxBkWr5lg7zU2knz9c
BjtZ3+Fohl2IiNLB03O4Rj1v8qodyjSx/ecgOffw6DPioCvCC9QoGVZJqP3a33Bu
317h2GCz/nanMB+JDKnj
=RuoE
-----END PGP SIGNATURE-----

--lUWNHpMBvmChTRKs--
