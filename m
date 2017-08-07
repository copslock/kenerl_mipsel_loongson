Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 17:32:44 +0200 (CEST)
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47375 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993376AbdHGPcdW5FRM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2017 17:32:33 +0200
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v77FUneN007450;
        Mon, 7 Aug 2017 10:32:23 -0500
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2c5a1w5ye8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2017 10:32:23 -0500
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod3.natinst.com (8.16.0.17/8.16.0.17) with ESMTPS id v77FWMto009791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2017 10:32:22 -0500
Received: from us-aus-exch5.ni.corp.natinst.com (130.164.68.15) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 7 Aug 2017 10:32:22 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch5.ni.corp.natinst.com (130.164.68.15) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 7 Aug 2017 10:32:21 -0500
Received: from nathan3500-linux-VM (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Mon, 7 Aug 2017 10:32:21 -0500
Date:   Mon, 7 Aug 2017 10:32:21 -0500
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] MIPS: NI 169445 board support
Message-ID: <20170807153221.GA28214@nathan3500-linux-VM>
References: <1500402549-12090-1-git-send-email-nathan.sullivan@ni.com>
 <20170807152648.GA13214@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170807152648.GA13214@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-08-07_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=30 reason=mlx scancount=1 engine=8.0.1-1706020000
 definitions=main-1708070259
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59393
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

On Mon, Aug 07, 2017 at 05:26:48PM +0200, Ralf Baechle wrote:
> On Tue, Jul 18, 2017 at 01:29:09PM -0500, Nathan Sullivan wrote:
> 
> > Support the National Instruments 169445 board.
> 
> Thanks, applied with minor changes:
> 
>   Ralf

Thank you for your patience!

   Nathan
