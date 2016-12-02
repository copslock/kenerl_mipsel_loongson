Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 18:30:42 +0100 (CET)
Received: from skprod2.natinst.com ([130.164.80.23]:47684 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993068AbcLBRagJXTCA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Dec 2016 18:30:36 +0100
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod2.natinst.com (8.15.0.59/8.15.0.59) with ESMTPS id uB2HULrw005080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2016 11:30:21 -0600
Received: from us-aus-exch5.ni.corp.natinst.com (130.164.68.15) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 2 Dec 2016 11:30:20 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch5.ni.corp.natinst.com (130.164.68.15) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 2 Dec 2016 11:30:20 -0600
Received: from nathan3500-linux-VM (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Fri, 2 Dec 2016 11:30:20 -0600
Date:   Fri, 2 Dec 2016 11:30:20 -0600
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
CC:     <ralf@linux-mips.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: NI 169445 board support
Message-ID: <20161202173020.GA22514@nathan3500-linux-VM>
References: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
 <04fd3008-14b1-b5e1-1895-093f0076644d@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04fd3008-14b1-b5e1-1895-093f0076644d@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-12-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1609300000
 definitions=main-1612020267
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55933
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

On Fri, Dec 02, 2016 at 04:21:59PM +0000, Zubair Lutfullah Kakakhel wrote:
> Hi,
> 
> On 12/02/2016 03:42 PM, Nathan Sullivan wrote:
> >Support the National Instruments 169445 board.
> 
> Interesting patch.
> 
> But do you happen to have a link to a description of the board?
> I couldn't find anything with a quick search.
> Perhaps the public name is something else?
> 
> Thanks,
> ZubairLK

This patch is for a pre-release board we have not made public yet.  It's a
straightforward MIPS system that will be used for networking, and we'd like to
get Linux support in place ahead of release.

Thanks,
Nathan
