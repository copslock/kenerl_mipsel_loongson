Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36HU1t02429
	for linux-mips-outgoing; Fri, 6 Apr 2001 10:30:01 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36HTxM02421
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 10:30:00 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id MAA00722
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 12:29:42 -0500
Message-ID: <3ACE0BA3.98823D4D@cotw.com>
Date: Fri, 06 Apr 2001 11:32:03 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: set_cp0_status (mipsregs.h)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Which is correct?
1 or 2 parameters ?
The first comes from a 2.4.0 kernel and the second from a 2.4.2
extracted from cvs a few days ago.

Thanks,
Scott

--------------------------------------------

/*
 * Manipulate the status register.
 * Mostly used to access the interrupt bits.
 */
#define __BUILD_SET_CP0(name,register)                          \
extern __inline__ unsigned int                                  \
set_cp0_##name(unsigned int change, unsigned int new)           \
{                                                               \
 unsigned int res;                                       \
                                                                \
 res = read_32bit_cp0_register(register);                \
 res &= ~change;                                         \
 res |= (new & change);                                  \
 if(change)                                              \
  write_32bit_cp0_register(register, res);        \
                                                                \
 return res;                                             \
}

__BUILD_SET_CP0(status,CP0_STATUS)
__BUILD_SET_CP0(cause,CP0_CAUSE)
__BUILD_SET_CP0(config,CP0_CONFIG)


------------------------- or --------------------------------

#define __BUILD_SET_CP0(name,register)                          \
extern __inline__ unsigned int                                  \
set_cp0_##name(unsigned int set)    \
{                                                               \
 unsigned int res;                                       \
                                                                \
 res = read_32bit_cp0_register(register);                \
 res |= set;      \
 write_32bit_cp0_register(register, res);         \
                                                                \
 return res;                                             \
}
