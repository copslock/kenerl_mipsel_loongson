Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6246CC43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334ED218A3
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 08:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfC3Inz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 04:43:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbfC3Inz (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Sat, 30 Mar 2019 04:43:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U8cLqW053439
        for <linux-mips@vger.kernel.org>; Sat, 30 Mar 2019 04:43:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rj4kw10ts-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@vger.kernel.org>; Sat, 30 Mar 2019 04:43:53 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 30 Mar 2019 08:43:52 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Mar 2019 08:43:49 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2U8hmdM58851470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 08:43:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A668D4C046;
        Sat, 30 Mar 2019 08:43:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66B034C052;
        Sat, 30 Mar 2019 08:43:48 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Mar 2019 08:43:48 +0000 (GMT)
Date:   Sat, 30 Mar 2019 09:43:47 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and
 alpha?
References: <201903291307.x2TD772v013534@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903291307.x2TD772v013534@sdf.org>
X-TM-AS-GCONF: 00
x-cbid: 19033008-4275-0000-0000-000003219C14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19033008-4276-0000-0000-00003830A0D3
Message-Id: <20190330084346.GA3801@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-30_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300063
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Mar 29, 2019 at 01:07:07PM +0000, George Spelvin wrote:
> (Cross-posted in case there are generic issues; please trim if
> discussion wanders into single-architecture details.)
> 
> I was working on some scaling code that can benefit from 64x64->128-bit
> multiplies.  GCC supports an __int128 type on processors with hardware
> support (including z/Arch and MIPS64), but the support was broken on
> early compilers, so it's gated behind CONFIG_ARCH_SUPPORTS_INT128.
> 
> Currently, of the ten 64-bit architectures Linux supports, that's
> only enabled on x86, ARM, and RISC-V.
> 
> SPARC and HP-PA don't have support.
> 
> But that leaves Alpha, Mips, PowerPC, and S/390x.
> 
> Current mips64, powerpc64, and s390x gcc seems to generate sensible code
> for mul_u64_u64_shr() in <linux/math64.h> if I cross-compile them.
> 
> I don't have easy access to an Alpha cross-compiler to test, but
> as it has UMULH, I suspect it would work, too.
> 
> Is there a reason it hasn't been enabled on these platforms?

It hasn't been enabled on s390 simply because at least I wasn't aware
of this config option. Feel free to send a patch, otherwise I will
enable this. Whatever you prefer.

Thanks for pointing this out!

