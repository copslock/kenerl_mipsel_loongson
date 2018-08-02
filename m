Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 13:56:19 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993973AbeHBL4QFUBAq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2018 13:56:16 +0200
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72BsCtn132202
        for <linux-mips@linux-mips.org>; Thu, 2 Aug 2018 07:56:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kkx7h8jjd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 02 Aug 2018 07:56:13 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 2 Aug 2018 12:56:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Aug 2018 12:56:02 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w72Bu1sw34865164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Aug 2018 11:56:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0EB11C04A;
        Thu,  2 Aug 2018 14:56:11 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74D4811C052;
        Thu,  2 Aug 2018 14:56:06 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.181])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Aug 2018 14:56:05 +0100 (BST)
Date:   Thu, 2 Aug 2018 14:55:51 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     "Fancer's opinion" <fancer.lancer@gmail.com>,
        Paul Burton <Paul.Burton@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: switch to NO_BOOTMEM
References: <1531727262-11520-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726070355.GD8477@rapoport-lnx>
 <20180726172005.pgjmkvwz2lpflpor@pburton-laptop>
 <CAMPMW8p092oXk1w+SVjgx-ZH+46piAY8xgYPDfLUwLCkBm-TVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMPMW8p092oXk1w+SVjgx-ZH+46piAY8xgYPDfLUwLCkBm-TVw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080211-0020-0000-0000-000002AFF113
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080211-0021-0000-0000-000020FC1D95
Message-Id: <20180802115550.GA10232@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808020125
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

Hi,

On Thu, Jul 26, 2018 at 10:55:53PM +0300, Fancer's opinion wrote:
> Hello, folks
> Regarding the no_bootmem patchset I've sent earlier.
> I'm terribly sorry about huge delay with response. I got sucked in a new
> project, so just didn't have a time to proceed with the series, answer to the
> questions and resend the set.
> If it is still relevant and needed for community, I can get back to the series
> on the next week, answer to the Mett's questions (sorry, man, for doing it so
> long), rebase it on top of the kernel 4.18 and resend the new version. We also
> can try to combine it with this patch, if it is found convenient.

So, what would be the best way to move forward?

> Regards,
> -Sergey
> 
> 
> On Thu, 26 Jul 2018, 20:20 Paul Burton, <paul.burton@mips.com> wrote:
> 
>     Hi Mike,
> 
>     On Thu, Jul 26, 2018 at 10:03:56AM +0300, Mike Rapoport wrote:
>     > Any comments on this?
> 
>     I haven't looked at this in detail yet, but there was a much larger
>     series submitted to accomplish this not too long ago, which needed
>     another revision:
> 
>         https://patchwork.linux-mips.org/project/linux-mips/list/?series=787&
>     state=*
> 
>     Given that, I'd be (pleasantly) surprised if this one smaller patch is
>     enough.
> 
>     Thanks,
>         Paul
> 

-- 
Sincerely yours,
Mike.
