Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2018 13:33:09 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992960AbeHWLdE5C4fu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Aug 2018 13:33:04 +0200
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NBUrEE113601
        for <linux-mips@linux-mips.org>; Thu, 23 Aug 2018 07:33:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1v43g30a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 23 Aug 2018 07:33:02 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <vaibhav@linux.ibm.com>;
        Thu, 23 Aug 2018 12:33:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 12:32:56 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NBWtco41156834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 11:32:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2940F11C04A;
        Thu, 23 Aug 2018 14:32:55 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9973611C052;
        Thu, 23 Aug 2018 14:32:51 +0100 (BST)
Received: from vajain21.in.ibm.com (unknown [9.109.223.99])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 23 Aug 2018 14:32:51 +0100 (BST)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 23 Aug 2018 17:02:51 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Stewart Smith <stewart@linux.ibm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Skiboot] [PATCH] opal/hmi: Wakeup the cpu before reading core_fir
In-Reply-To: <20180821133842.1b13e972@roar.ozlabs.ibm.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop> <20180820223618.22319-1-paul.burton@mips.com> <20180820223618.22319-2-paul.burton@mips.com> <20180820140605.11846-1-vaibhav@linux.ibm.com> <20180821133842.1b13e972@roar.ozlabs.ibm.com>
Date:   Thu, 23 Aug 2018 17:02:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082311-0016-0000-0000-000001FAACB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082311-0017-0000-0000-000032510788
Message-Id: <877ekhnwrg.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=656 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230124
Return-Path: <vaibhav@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vaibhav@linux.ibm.com
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

Thanks for reviewing this patch Nick

Nicholas Piggin <npiggin@gmail.com> writes:
>
> Would it be feasible to enumerate the ranges of scoms that require
> special wakeup and check for those in xscom_read/write, and warn if
> spwkup was not set?
>
I think that might be racy (Vaidy please correct if I am wrong) as a
core can change its state when we read its sleep state and when we do
the actual xscom to read the core_fir.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
