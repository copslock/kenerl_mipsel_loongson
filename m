Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 16:15:39 +0200 (CEST)
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36059 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992800AbdHHOP1BbZOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 16:15:27 +0200
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v78E9jMF028759;
        Tue, 8 Aug 2017 09:15:18 -0500
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2c5bhqaxvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2017 09:15:18 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod3.natinst.com (8.16.0.17/8.16.0.17) with ESMTPS id v78EFHP3006662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2017 09:15:17 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 8 Aug 2017 09:15:17 -0500
Received: from nathan3500-linux-VM (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Tue, 8 Aug 2017 09:15:17 -0500
Date:   Tue, 8 Aug 2017 09:15:17 -0500
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/7] MIPS: NI 169445: Only include in 32r2el kernels
Message-ID: <20170808141517.GA27246@nathan3500-linux-VM>
References: <20170807230119.10629-1-paul.burton@imgtec.com>
 <20170807230119.10629-4-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170807230119.10629-4-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=30 reason=mlx scancount=1 engine=8.0.1-1706020000
 definitions=main-1708080226
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan.sullivan@ni.com
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

On Mon, Aug 07, 2017 at 04:01:14PM -0700, Paul Burton wrote:
> The NI 169445 board uses a little endian MIPS32r2 CPU, and therefore
> including board support in kernels that are unable to run on such a CPU
> is pointless.
>

Acked-by: Nathan Sullivan <nathan.sullivan@ni.com>
