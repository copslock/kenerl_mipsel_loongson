Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 10:24:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5178 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007571AbbCZJYWJISSO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 10:24:22 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B6B8741F8D96;
        Thu, 26 Mar 2015 09:24:15 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 26 Mar 2015 09:24:15 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 26 Mar 2015 09:24:15 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 97BADCB4A5671;
        Thu, 26 Mar 2015 09:24:13 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 26 Mar 2015 09:24:15 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 26 Mar
 2015 09:24:14 +0000
Message-ID: <5513D037.40003@imgtec.com>
Date:   Thu, 26 Mar 2015 09:24:07 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] MIPS: Add CDMM bus support
References: <20150325123756.GA2200@kroah.com> <1427297990-14023-1-git-send-email-james.hogan@imgtec.com> <20150325220339.GC10513@kroah.com>
In-Reply-To: <20150325220339.GC10513@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="FFRhi57dN3j7HTnhB6EWF4iOhkMjW5upk"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46537
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

--FFRhi57dN3j7HTnhB6EWF4iOhkMjW5upk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/03/15 22:03, Greg Kroah-Hartman wrote:
> On Wed, Mar 25, 2015 at 03:39:50PM +0000, James Hogan wrote:
>> Add MIPS Common Device Memory Map (CDMM) support in the form of a bus =
in
>> the standard Linux device model. Each device attached via CDMM is
>> discoverable via an 8-bit type identifier and may contain a number of
>> blocks of memory mapped registers in the CDMM region. IRQs are expecte=
d
>> to be handled separately.
>>
>> Due to the per-cpu (per-VPE for MT cores) nature of the CDMM devices,
>> all the driver callbacks take place from workqueues which are run on t=
he
>> right CPU for the device in question, so that the driver doesn't need =
to
>> be as concerned about which CPU it is running on. Callbacks also exist=

>> for when CPUs are taken offline, so that any per-CPU resources used by=

>> the driver can be disabled so they don't get forcefully migrated. CDMM=

>> devices are created as children of the CPU device they are attached to=
=2E
>>
>> Any existing CDMM configuration by the bootloader will be inherited,
>> however platforms wishing to enable CDMM should implement the weak
>> mips_cdmm_phys_base() function (see asm/cdmm.h) so that the bus driver=

>> knows where it should put the CDMM region in the physical address spac=
e
>> if the bootloader hasn't already enabled it.
>>
>> A mips_cdmm_early_probe() function is also provided to allow early boo=
t
>> or particularly low level code to set up the CDMM region and probe for=
 a
>> specific device type, for example early console or KGDB IO drivers for=

>> the EJTAG Fast Debug Channel (FDC) CDMM device.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-mips@linux-mips.org
>> ---
>> Changes in v3:
>> - Convert to use dev_groups rather than dev_attrs (GregKH).
>> - Rename mips_cdmm_attr_func() macro to CDMM_ATTR for consistency with=

>>   other similar macro names I've seen around the kernel.
>> - Add modalias attribute.
>>
>> Changes in v2:
>> - Fix some checkpatch errors.
>> - Correct CDMM name in various places. It is "Common Device Memory Map=
",
>>   rather than "Common Device Mapped Memory" (which for some reason had=

>>   got stuck in my head).
>> ---
>>  arch/mips/include/asm/cdmm.h      |  87 +++++
>>  drivers/bus/Kconfig               |  13 +
>>  drivers/bus/Makefile              |   1 +
>>  drivers/bus/mips_cdmm.c           | 716 +++++++++++++++++++++++++++++=
+++++++++
>>  include/linux/mod_devicetable.h   |   8 +
>>  scripts/mod/devicetable-offsets.c |   3 +
>>  scripts/mod/file2alias.c          |  16 +
>>  7 files changed, 844 insertions(+)
>>  create mode 100644 arch/mips/include/asm/cdmm.h
>>  create mode 100644 drivers/bus/mips_cdmm.c
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks Greg!

Cheers
James


--FFRhi57dN3j7HTnhB6EWF4iOhkMjW5upk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVE9A+AAoJEGwLaZPeOHZ61owP/jiNaOEHXobzN7jChahM0XOs
OkfFaBB5EbrYpZmhR/w2VF4ieQFKRxDDI/7A/AI5i40C0Sy3tyekDVvLh+zIJPo8
EmA+5gQY7Jnzu/ZaR0QaagtEwJEHnZtGsSjT7dxaijtqhn/9rQbhA+hQrgQabhCz
2iPQDrCflv4rJAItUAxXQ+kiPtdePNOvYxxzImoPjR/NhazxAKZ0OrY2Ct2iX4Bu
nTqErjq4y9spBJ5jxbWQy2z49THjC1xjFO2L3n15jBGOxnCREMrFlGHKulxx9C08
g5IedJ6bh2vUg2kF+aEB3S5D4GmYW/aiow47/ut4IaZ6OGlm09N770fvrwf1rwa+
qaS9XzT9kXswlKVagsNsm4sNiDDfnm90L0xUNMlNrhD8XtpTysq8EzQde6oFSoNw
cq4Rp9Z6ItDN5VyndgAmsT5Z+TvDGFSv/GjPe2k59l8Al+BvvZdxWFsqcG17Mqi0
e0VRMtI6ampr7SvlBXMGaI1C6XNsfLyihLD/HkJVGFtAVCUJTTFa8GyClA41I3Of
b+LBpfA4McRK/ZrmSdAzwi71ldIoCjF1JPO4kQ3JPLrkSrmRcw2BqLclBxzyn9/S
olox834sSvDY5rsYUt+Yv4E9H9k1h1s2V4ZGCd2FelFpm1ttI0iTYKm1lHQS2+dS
pOAt28LJBPR+E4dPRw7u
=G8Ce
-----END PGP SIGNATURE-----

--FFRhi57dN3j7HTnhB6EWF4iOhkMjW5upk--
