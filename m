Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 17:38:51 +0100 (CET)
Received: from skprod3.natinst.com ([130.164.80.24]:35075 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991965AbdADQio7RvUM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jan 2017 17:38:44 +0100
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod3.natinst.com (8.15.0.59/8.15.0.59) with ESMTPS id v04Gcamg022186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2017 10:38:36 -0600
Received: from us-aus-exch4.ni.corp.natinst.com (130.164.68.14) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 4 Jan 2017 10:38:36 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
 us-aus-exch4.ni.corp.natinst.com (130.164.68.14) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 4 Jan 2017 10:38:35 -0600
Received: from nathan3500-linux-VM (130.164.49.7) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Wed, 4 Jan 2017 10:38:35 -0600
Date:   Wed, 4 Jan 2017 10:38:36 -0600
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: NI 169445 board support
Message-ID: <20170104163836.GA18069@nathan3500-linux-VM>
References: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
 <20161220163434.GA15962@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161220163434.GA15962@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-01-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1612050000
 definitions=main-1701040258
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56158
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

On Tue, Dec 20, 2016 at 05:34:34PM +0100, Ralf Baechle wrote:
> On Fri, Dec 02, 2016 at 09:42:09AM -0600, Nathan Sullivan wrote:
> > Date:   Fri, 2 Dec 2016 09:42:09 -0600
> > From: Nathan Sullivan <nathan.sullivan@ni.com>
> > To: ralf@linux-mips.org, mark.rutland@arm.com, robh+dt@kernel.org
> > CC: linux-mips@linux-mips.org, devicetree@vger.kernel.org,
> >  linux-kernel@vger.kernel.org, Nathan Sullivan <nathan.sullivan@ni.com>
> > Subject: [PATCH] MIPS: NI 169445 board support
> > Content-Type: text/plain
> > 
> > Support the National Instruments 169445 board.
> 
> Nathan,
> 
> I assume you're going to repost the changes Rob asked for in
> https://patchwork.linux-mips.org/patch/14641/#26924 and resubmit?
> 
> Thanks,
> 
>   Ralf

Hmm, I found the issue with the generic MIPS config and dwc_eth_qos.  The NIC
driver attempts to cache align a descriptor ring using the ___cacheline_aligned
attribute on the descriptor struct, in combination with a "skip" feature in
hardware.  However, the skip feature only has a three bit field, and the generic
MIPS config selects MIPS_L1_CACHE_SHIFT_7.  So, the line size is 128, and with a
64-bit bus, that means the NIC descriptor skip field would need to be set to
14 to align the 16-byte descriptors...

I guess it makes sense for a generic MIPS kernel to align everything for 128 byte
cache lines, and for me to fix the dwc_eth_qos driver to handle cases where the
line size is too big for the hardware skip feature, right?

Thanks,

   Nathan
