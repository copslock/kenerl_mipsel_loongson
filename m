Return-Path: <SRS0=MCbt=SR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7732EC10F12
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 10:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4840A206BA
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 10:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkiPsFxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfDOKN7 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:13:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54394 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOKN7 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 15 Apr 2019 06:13:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FA8Ule131521;
        Mon, 15 Apr 2019 10:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=YoMWmUaIuhPWO6FEtWwrQktpmL4pDG/BBVlcee6yDfE=;
 b=dkiPsFxFARZHO8s5GhtIc9W+Ua/BB8ArL9gL0S4apvcmpbFv4Qq5c9ctchFDiwT/M6b2
 mqa3kgf4ykq/sRcF4xmGL1mtLKZTeAoUdFCUhVS+EB3aswa7IuJEbp0Gq16PyICqTibx
 SjTX8OHfHCQJRNM63Ib74hA9hCVxFm/XT3R13vz7MFgxkq2F3kRNaCfQ3xcf9PMl1eyf
 Kn3HzmOKUYJ/K3MUs+TXxxRUQXuUNBGqBbJzNdFHHf6+8pIsCOCSnbltssuRk7Rw/+SW
 y5ZDZZ00HbckDtY+Fap94sV/ze7rlw5VPKZznkO/NwtWS1VHZ53D9m+bArDCVnECy2+W cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2ru59cwvfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 10:12:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FACObS176437;
        Mon, 15 Apr 2019 10:12:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rv2tu3b2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 10:12:26 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3FACIeb009910;
        Mon, 15 Apr 2019 10:12:22 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 03:12:18 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 1/2] include: linux: Regularise the use of FIELD_SIZEOF
 macro
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190414091452.22275-1-shyam.saini@amarulasolutions.com>
Date:   Mon, 15 Apr 2019 04:12:16 -0600
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, bpf@vger.kernel.org,
        kvm@vger.kernel.org, mayhs11saini@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C398B8C9-6A54-4590-AA88-58D514BAEB71@oracle.com>
References: <20190414091452.22275-1-shyam.saini@amarulasolutions.com>
To:     Shyam Saini <shyam.saini@amarulasolutions.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150072
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150072
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



> On Apr 14, 2019, at 3:14 AM, Shyam Saini =
<shyam.saini@amarulasolutions.com> wrote:
>=20
> Currently, there are 3 different macros, namely sizeof_field, =
SIZEOF_FIELD
> and FIELD_SIZEOF which are used to calculate the size of a member of
> structure, so to bring uniformity in entire kernel source tree lets =
use
> FIELD_SIZEOF and replace all occurrences of other two macros with =
this.
>=20
> For this purpose, redefine FIELD_SIZEOF in include/linux/stddef.h and
> tools/testing/selftests/bpf/bpf_util.h and remove its defination from
> include/linux/kernel.h


> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -20,6 +20,15 @@ enum {
> #endif
>=20
> /**
> + * FIELD_SIZEOF - get the size of a struct's field
> + * @t: the target struct
> + * @f: the target struct's field
> + * Return: the size of @f in the struct definition without having a
> + * declared instance of @t.
> + */
> +#define FIELD_SIZEOF(t, f) (sizeof(((t *)0)->f))
> +
> +/**
>  * sizeof_field(TYPE, MEMBER)
>  *
>  * @TYPE: The structure containing the field of interest
> @@ -34,6 +43,6 @@ enum {
>  * @MEMBER: The member within the structure to get the end offset of
>  */
> #define offsetofend(TYPE, MEMBER) \
> -	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
> +	(offsetof(TYPE, MEMBER)	+ FIELD_SIZEOF(TYPE, MEMBER))

If you're doing this, why are you leaving the definition of =
sizeof_field() in
stddef.h untouched?

Given the way this has worked historically, if you are leaving it in =
place for
source compatibility reasons, shouldn't it be redefined in terms of
FIELD_SIZEOF(), e.g.:

#define sizeof_field(TYPE, MEMBER) FIELD_SIZEOF(TYPE, MEMBER)



