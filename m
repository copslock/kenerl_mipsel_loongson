Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2018 09:20:15 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992835AbeK0IUHWdvcg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2018 09:20:07 +0100
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAR8Ju0B039874
        for <linux-mips@linux-mips.org>; Tue, 27 Nov 2018 03:20:06 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p117r2wka-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 27 Nov 2018 03:20:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <brueckner@linux.ibm.com>;
        Tue, 27 Nov 2018 08:19:54 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 08:19:47 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAR8Jk7a55115794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 08:19:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA96A4055;
        Tue, 27 Nov 2018 08:19:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB5D4A404D;
        Tue, 27 Nov 2018 08:19:45 +0000 (GMT)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.152.224.146])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Nov 2018 08:19:45 +0000 (GMT)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1gRYav-0001sE-I5; Tue, 27 Nov 2018 09:19:45 +0100
Date:   Tue, 27 Nov 2018 09:19:45 +0100
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH v2 15/20] s390: perf/events: advertise PMU exclusion
 capability
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
 <1543230756-15319-16-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543230756-15319-16-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112708-0008-0000-0000-0000029913EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112708-0009-0000-0000-0000220356F6
Message-Id: <20181127081945.GA4817@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=746 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270075
Return-Path: <brueckner@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brueckner@linux.ibm.com
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

On Mon, Nov 26, 2018 at 11:12:31AM +0000, Andrew Murray wrote:
> The s390 cpum_cf and cpum_sf PMUs have the capability to exclude
> events based on context. Let's advertise that we support the
> PERF_PMU_CAP_EXCLUDE capability to ensure that perf doesn't
> prevent us from handling events where any exclusion flags are set.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 1 +
>  arch/s390/kernel/perf_cpum_sf.c | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
