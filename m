Received:  by oss.sgi.com id <S553781AbRCLRsu>;
	Mon, 12 Mar 2001 09:48:50 -0800
Received: from [207.81.221.34] ([207.81.221.34]:54324 "EHLO relay")
	by oss.sgi.com with ESMTP id <S553692AbRCLRsq>;
	Mon, 12 Mar 2001 09:48:46 -0800
Received: from vcubed.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id OAA05822
	for <linux-mips@oss.sgi.com>; Mon, 12 Mar 2001 14:11:14 -0500
Message-ID: <3AAD0CB9.FAE7C050@vcubed.com>
Date:   Mon, 12 Mar 2001 12:51:53 -0500
From:   Dan Aizenstros <dan@vcubed.com>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Error in set_cp0_ functions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello All,

There appears to be an error in the new set_cp0_ functions in
the mipsregs.h file.

#define __BUILD_SET_CP0(name,register)                          \
extern __inline__ unsigned int                                  \
set_cp0_##name(unsigned int set)                                \
{                                                               \
        unsigned int res;                                       \
                                                                \
        res = read_32bit_cp0_register(register);                \
        res |= ~set;                                            \
        write_32bit_cp0_register(register, res);                \
                                                                \
        return res;                                             \
}                                                               \

The line
	res |= ~set;
will set every bit except the bit you want to set.

It should be changed to
	res |= set;

Also in the mipsregs.h file the line

#define ST0_UM                 <1   <<  4)

should probably be

#define ST0_UM                 (1   <<  4)

I hope this helps.

Dan Aizenstros
Software Engineer
V3 Semiconductor Corp.
