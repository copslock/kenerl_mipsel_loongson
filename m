Received:  by oss.sgi.com id <S553748AbRAYC3A>;
	Wed, 24 Jan 2001 18:29:00 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:53747 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553685AbRAYC2a>;
	Wed, 24 Jan 2001 18:28:30 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0P2POI19844
	for <linux-mips@oss.sgi.com>; Wed, 24 Jan 2001 18:25:24 -0800
Message-ID: <3A6F8F66.6258801@mvista.com>
Date:   Wed, 24 Jan 2001 18:28:54 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: floating point on Nevada cpu
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


This simple test fails on a Nevada (5231) cpu:

int main()
{
    float x1,x2,x3;

    x1 = 7.5;
    x2 = 2.0;
    x3 = x1/x2;
    printf("x3 = %f\n", x3);
}

Has anyone else used floating point with 52xx processors?

Pete
